diag_log format["[GMSAI] _monitorVehiclePatrols called at %1",diag_tickTime];
for "_i" from 1 to (count GMSAI_vehiclePatrols) do
{
	if (_i > (count GMSAI_vehiclePatrols)) exitWith {};
	private _vehiclePatrol = GMSAI_vehiclePatrols deleteAt 0;
	_vehiclePatrol params["_crewGroup","_vehicle","_lastSpawned","_timesSpawned","_respawnAt"];  //,"_spawned"];
	if (_lastSpawned > 0) then
	{
		private _countUnits = {alive _x} count (units _crewGroup);
		private _countCrew = {alive _x} count (crew _vehicle);
		if ( ({alive _x} count (crew _vehicle) > 0) && (alive _vehicle)) then
		{
			diag_log format["_monitorVehiclePatrols: checking vehicle %1 with %2 alive crew located at %3 with speed of %4",_vehicle,{alive _x} count (crew _vehicle),getPos _vehicle,speed _vehicle];
			if (diag_tickTime > (_crewGroup getVariable "timestamp") + 600) then
			{
				diag_log format["_monitorVehiclePatrols: vehicle %1 delayed in arriving at WP, re-directing it",_vehicle];
				(leader _crewGroup) call GMSAI_fnc_nextWaypointVehicle;
			};
			GMSAI_vehiclePatrols pushBack _vehiclePatrol;
		} else {
			if ({alive _x} count (units _crewGroup) > 0 && )
			diag_log format["_monitorVehiclePatrols: vehicle patrol killed, configuring it for respawn"];
			//if (alive _vehicle) then {GMSAI_emptyVehicles pushBack [_vehicle,diag_tickTime + GMSAI_vehicleDeleteTimer]};
			_vehiclePatrol set[4,diag_tickTime + ([GMSAI_vehiclePatrolRespawnTime] call GMS_fnc_getNumberFromRange)];
			_vehiclePatrol set[2,-1];
			GMSAI_vehiclePatrols pushBack _vehiclePatrol;			
		};
	} else {  // 
		if (GMSAI_vehiclePatrolRespawns == -1 || _timesSpawned <= GMSAI_vehiclePatrolRespawns) then
		{
			if (_respawnAt > -1 && diag_tickTime > _respawnAt) then
			{
				private _pos = [0,0];
				while {_pos isEqualTo [0,0]} do
				{
					_pos = [nil,["water"]] call BIS_fnc_randomPos;
					diag_log format["[GMSAI] _initializeVehiclePatrols: _pos = %1",_pos];
				};
				private _newPatrol = [_pos] call GMSAI_fnc_spawnVehiclePatrol;
				_vehiclePatrol set[0,_newPatrol select 0];
				_vehiclePatrol set[1,_newPatrol select 1];
				_vehiclePatrol set[2,diag_tickTime];
				_vehiclePatrol set[3,_timesSpawned + 1];
			};
			GMSAI_vehiclePatrols pushBack _vehiclePatrol;
		};
	};
	
};