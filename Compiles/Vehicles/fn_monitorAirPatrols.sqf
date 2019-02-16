diag_log format["[GMSAI] _monitorAirPatrols called at %1",diag_tickTime];
for "_i" from 1 to (count GMSAI_airPatrols) do
{
	if (_i > (count GMSAI_airPatrols)) exitWith {};
	private _airPatrol = GMSAI_airPatrols deleteAt 0;
	_airPatrol params["_crewGroup","_aircraft","_lastSpawned","_timesSpawned","_respawnAt"];  //,"_spawned"];
	if (_lastSpawned > 0) then
	{
		if (!(_crewGroup isEqualTo grpNull) && !(_aircraft isEqualTo objNull) && {alive _x} count (crew _aircraft) > 0) then
		{
			if (diag_tickTime > (_crewGroup getVariable "timestamp") + 600) then
			{
				(leader _crewGroup) call GMSAI_fnc_nextWaypointAircraft;
			};
			//  Do a check for spawning paratroops
			if (_aircraft getVariable ["paratroopsSpawnedTime",0] == 0 || ( _aircraft getVariable ["paratroopsSpawnedTime",0] != 0) && diag_tickTime > (_aircraft getVariable ["paratroopsSpawnedTime",0]) + GMSAI_paratroopRespawnTimer) then
			{
				private _nearestEnemy =  (leader _crewGroup) findNearestEnemy (position (leader _crewGroup));
				if !(isNull _nearestEnemy) then
				{
					if (random(1) < GMSAI_aircraftChanceOfParatroops) then
					{
						[_aircraft] call GMSAI_fnc_spawnParatroops;
					};
					_crewGroup setVariable["paratroopsSpawnedTime",diag_tickTime];  //  reset timer whether or not paratroops were spawned.
				};
			};
			GMSAI_airPatrols pushBack _airPatrol;
		} else {
			_airPatrol set[4,diag_tickTime + [GMSAI_aircraftRespawnTime] call GMS_fnc_getNumberFromRange];
			_airPatrol set[2,-1];
			GMSAI_airPatrols pushBack _airPatrol;			
		};
	} else {
		if (GMSAI_airpatrolResapwns == -1 || _timesSpawned <= GMSAI_airpatrolResapwns) then
		{
			if (_respawnAt > -1 && diag_tickTime > _respawnAt) then
			{
				private _pos = [nil,["water"] /*+ any blacklisted locations*/] call BIS_fnc_randomPos;
				private _newPatrol = [_pos] call GMSAI_fnc_spawnHelicoptorPatrol;
				_airPatrol set[0,_newPatrol select 0];
				_airPatrol set[1,_newPatrol select 1];
				_airPatrol set[2,diag_tickTime];
				_airPatrol set[3,_timesSpawned + 1];
				//_airPatrol set[4,-1]; // reset last spawned							
				//_airPatrol set[5,-1];
			};
			GMSAI_airPatrols pushBack _airPatrol;
		};
	};
};
