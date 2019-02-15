//diag_log format["[GMSAI] _monitorAirPatrols called at %1",diag_tickTime];
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
			_airPatrol set[4,diag_tickTime + [GMSAI_respawnTimeAircraftPatrol] call GMS_fnc_getNumberFromRange];
			GMSAI_airPatrols pushBack _airPatrol;
		} else {
			if (_crewGroup isEqualTo grpNull) then
			{
				_airPatrol set[4,diag_tickTime + [GMSAI_respawnTimeAircraftPatrol] call GMS_fnc_getNumberFromRange];
				GMSAI_airPatrols pushBack _airPatrol;
			} else {
				if ({alive _x} count (crew _aircraft) isEqualTo 0) then
				{
					_airPatrol set[4,diag_tickTime + [GMSAI_respawnTimeAircraftPatrol] call GMS_fnc_getNumberFromRange];				
					GMSAI_airPatrols pushBack _airPatrol;
					[_aircraft] call GMSAI_fnc_processEmptyVehicle;
				} else {
					if (_respawnAt > -1 && diag_tickTime > _respawnAt) then
					{
						if (GMSAI_airpatrolResapwns == -1 || _timesSpawned <= GMSAI_airpatrolResapwns) then
						{
							private _pos = [nil,["water"] /*+ any blacklisted locations*/] call BIS_fnc_randomPos;
							private _heliPatrol = [_pos] call GMSAI_fnc_spawnHelicoptorPatrol;
							_airPatrol set[0,_heliPatrol select 0];
							_airPatrol set[1,_heliPatrol select 1];
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
	1. 1 or more crew of the aircraft are alive - do nothing.
	else 
	2. all crew are dead or the group == grpNull - 
		-> set _respawnAt = diag_tickTime + GMSAI_paratroopRespawnTimer;
		-> if vehicles should be released to players, eject any crew and unlock vehicle and remove all event handlers.
	else 
	3. if (_aircraft == objNull) then aircraft was destroyed so - 
		-> set _respawnAt = diag_tickTime + GMSAI_paratroopRespawnTimer;
	else 
	4. if (_respawnAt > -1 && diag_tickTime > _respawnAt) then -
		- find a random location
				private _pos = [nil,["water"] + any blacklisted locations] call BIS_fnc_randomPos;
				private _heliPatrol = [_pos] call GMSAI_fnc_spawnHelicoptorPatrol;
				_x set[0,_heliPatrol select 0];
				_x set[1,_heliPatrol select 1];
				_x set[2,diag_tickTime];
				_x set[3,_timesSpawned + 1];
				_x set[4,-1] // reset last spawned
