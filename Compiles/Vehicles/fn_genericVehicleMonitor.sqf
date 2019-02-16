diag_log format["[GMSAI] genericVehicleMonitor called at %1",diag_tickTime];
params["_vehiclePatrols","_respawnTime"];
for "_i" from 1 to (count _vehiclePatrols) do
{
	if (_i > (count _vehiclePatrols)) exitWith {};
	private _patrolParameters = _vehiclePatrols deleteAt 0;
	_patrolParameters params["_crewGroup","_vehicle","_lastSpawned","_timesSpawned","_respawnAt"];
	if (!(_vehicle isEqualTo objNull) && ({alive _x} count (crew _vehicle) > 0)) then  // Most likely scenario
	{
		//  Place check for stuck or wayward vehicles here
		_vehiclePatrols pushBack _patrolParameters;
	} else {
		if (_vehicle isEqualTo objNull) then 
		{
			if (_respawnAt > -1 && diag_tickTime > _respawnAt) then
			{
				if (GMSAI_airpatrolResapwns == -1 || _timesSpawned <= GMSAI_airpatrolResapwns) then
				{
					private _pos = [nil,["water"] /*+ any blacklisted locations*/] call BIS_fnc_randomPos;
					private _newPatrol = [_pos] call GMSAI_fnc_spawnHelicoptorPatrol;
					_airPatrol set[0,_newPatrol select 0];
					_airPatrol set[1,_newPatrol select 1];
					_airPatrol set[2,diag_tickTime];
					_airPatrol set[3,_timesSpawned + 1];
					_airPatrol set[4,-1]; // reset last spawned							
					GMSAI_airPatrols pushBack _airPatrol;
				};
			};
		} else {
				
		}
	};
};

for "_i" from 1 to (count GMSAI_airPatrols) do
{
	if (_i > (count GMSAI_airPatrols)) exitWith {};
	private _airPatrol = GMSAI_airPatrols deleteAt 0;
	_airPatrol params["_crewGroup","_aircraft","_lastSpawned","_timesSpawned","_respawnAt"];
	if (!(_aircraft isEqualTo objNull && {alive _x} count (crew _aircraft) > 0)) then
	{
		GMSAI_airPatrols pushBack _airPatrol;
	} else {
		if (_aircraft isEqualTo objNull) then
		{
			_airPatrol set[4,diag_tickTime + [GMSAI_aircraftRespawnTime] call GMS_fnc_getNumberFromRange];
			GMSAI_airPatrols pushBack _airPatrol;
		} else {
			if (_crewGroup isEqualTo grpNull) then
			{
				_airPatrol set[4,diag_tickTime + [GMSAI_aircraftRespawnTime] call GMS_fnc_getNumberFromRange];
				GMSAI_airPatrols pushBack _airPatrol;
			} else {
				if ({alive _x} count (crew _aircraft) isEqualTo 0) then
				{
					_airPatrol set[4,diag_tickTime + [GMSAI_aircraftRespawnTime] call GMS_fnc_getNumberFromRange];				
					GMSAI_airPatrols pushBack _airPatrol;
					[_aircraft] call GMSAI_fnc_processEmptyVehicle;
				} else {
					if (_respawnAt > -1 && diag_tickTime > _respawnAt) then
					{
						if (GMSAI_airpatrolResapwns == -1 || _timesSpawned <= GMSAI_airpatrolResapwns) then
						{
							private _pos = [nil,["water"] /*+ any blacklisted locations*/] call BIS_fnc_randomPos;
							private _newPatrol = [_pos] call GMSAI_fnc_spawnHelicoptorPatrol;
							_airPatrol set[0,_newPatrol select 0];
							_airPatrol set[1,_newPatrol select 1];
							_airPatrol set[2,diag_tickTime];
							_airPatrol set[3,_timesSpawned + 1];
							_airPatrol set[4,-1]; // reset last spawned							
							GMSAI_airPatrols pushBack _airPatrol;
						};
					//} else {
						
					};
				};
			}; 
		};	
	};
};

/*
	// Can we do this as a switch? does that make sense ?
	Possible states 

	0.  1 or more crew of the aircraft are alive - check the timestap and type of the current waypoint; call next waypoint if not in SAD mode and time elapsed > 300 sec.
	else  
	1. if (_respawnAt > -1 && diag_tickTime > _respawnAt) then -
		- find a random location
				private _pos = [nil,["water"] + any blacklisted locations] call BIS_fnc_randomPos;
				private _newPatrol = [_pos] call GMSAI_fnc_spawnHelicoptorPatrol;
				_x set[0,_newPatrol select 0];
				_x set[1,_newPatrol select 1];
				_x set[2,diag_tickTime];
				_x set[3,_timesSpawned + 1];	
	else 
	2. The aircraft is marked for deletion 
		setup for respawn at a later time
	else 
	3. if all crew are dead or the group == grpNull - // Should never happen without the aircraft being marked for deletion BUT - if it did, handle it as a backup
		-> set _respawnAt = diag_tickTime + GMSAI_aircraftRespawnTime;
		-> if vehicles should be released to players, eject any crew and unlock vehicle and remove all event handlers.
	else 
	4. (damage _aircraft > 0.95) -> assume aircraft is destroyed or grounded -> respawn condition.
	else 
	5. if (_aircraft == objNull) then aircraft was destroyed so - 
		-> set _respawnAt = diag_tickTime + GMSAI_aircraftRespawnTime;

				_x set[4,-1] // reset last spawned