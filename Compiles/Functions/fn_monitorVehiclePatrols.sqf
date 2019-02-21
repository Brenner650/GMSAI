diag_log format["[GMSAI] _monitorVehiclePatrols called at %1",diag_tickTime];
for "_i" from 1 to (count GMSAI_vehiclePatrols) do
{
	if (_i > (count GMSAI_vehiclePatrols)) exitWith {};
	private _vehiclePatrol = GMSAI_vehiclePatrols deleteAt 0;
	_vehiclePatrol params["_crewGroup","_vehicle","_lastSpawned","_timesSpawned","_respawnAt"];  //,"_spawned"];
	if (_lastSpawned > 0) then
	{
		if (!(_crewGroup isEqualTo grpNull) && !(_vehicle isEqualTo objNull) && {alive _x} count (crew _vehicle) > 0) then
		{
			if (diag_tickTime > (_crewGroup getVariable "timestamp") + 600) then
			{
				(leader _crewGroup) call GMSAI_fnc_nextWaypointVehicle;
			};
			/*
			//  Do a check for spawning paratroops
			if (_vehicle getVariable ["paratroopsSpawnedTime",0] == 0 || ( _vehicle getVariable ["paratroopsSpawnedTime",0] != 0) && diag_tickTime > (_vehicle getVariable ["paratroopsSpawnedTime",0]) + GMSAI_paratroopRespawnTimer) then
			{
				private _nearestEnemy =  (leader _crewGroup) findNearestEnemy (leader _crewGroup);
				if !(isNull _nearestEnemy) then
				{
					if (random(1) < GMSAI_vehicleChanceOfPParatroops) then
					{
						[_vehicle] call GMSAI_fnc_flyInParatroops;
					};
					_crewGroup setVariable["paratroopsSpawnedTime",diag_tickTime];  //  reset timer whether or not paratroops were spawned.
				};
			};
			*/
			GMSAI_vehiclePatrols pushBack _vehiclePatrol;
		} else {
			_vehiclePatrol set[4,diag_tickTime + [GMSAI_vehiclePatrolRespawnTime] call GMS_fnc_getNumberFromRange];
			_vehiclePatrol set[2,-1];
			GMSAI_vehiclePatrols pushBack _vehiclePatrol;			
		};
	} else {
		if (GMSAI_vehiclePatrolRespawns == -1 || _timesSpawned <= GMSAI_vehiclePatrolResapwns) then
		{
			if (_respawnAt > -1 && diag_tickTime > _respawnAt) then
			{
				private _pos = [nil,["water"] /*+ any blacklisted locations*/] call BIS_fnc_randomPos;
				private _newPatrol = [_pos] call GMSAI_fnc_spawnVehiclePatrol;
				_vehiclePatrol set[0,_newPatrol select 0];
				_vehiclePatrol set[1,_newPatrol select 1];
				_vehiclePatrol set[2,diag_tickTime];
				_vehiclePatrol set[3,_timesSpawned + 1];
				//_vehiclePatrol set[4,-1]; // reset last spawned							
				//_vehiclePatrol set[5,-1];
			};
			GMSAI_vehiclePatrols pushBack _vehiclePatrol;
		};
	};
};