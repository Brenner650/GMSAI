//diag_log format["[GMSAI] running inactive area monitor at %1 with %2 inactive spawns",diag_tickTime, count GMSAI_StaticSpawns];
#define respawnAt 4
#define areaDescriptor 0
#define GMSAI_staticDespawnDistance 400
private _spawns = [];
for "_i" from 1 to (count GMSAI_StaticSpawns) do
{
	if (_i > (count GMSAI_StaticSpawns)) exitWith {};
	private _area = GMSAI_StaticSpawns deleteAt 0;
	if !(isNil "_area") then
	{
		if (GMSAI_staticRespawns == -1 || (_area select 5) < GMSAI_staticRespawns) then
		{
			if (diag_tickTime > (_area select respawnAt)) then
			{
				//diag_log format["[GMSAI] player(s) detected in area %1",_area];
				//diag_log format["[GMSAI] time = %1 | respawnAt = %2",diag_tickTime,_area select respawnAt];	
				private _players = allPlayers inAreaArray (_area select areaDescriptor);
				if !(_players isEqualTo []) then 
				{
					//_area params["_areaDescriptor","_staticAiDescriptor","_spawnType","_spawnedGroups","_respawnAt","_timesSpawned"];
					if (random(1) < ((_area select 1) select 3)) then
					{
						_area params["_areaDescriptor","_staticAiDescriptor","_spawnType","_spawnedGroups","_respawnAt","_timesSpawned"];	
						_area set[5, (_timesSpawned + 1)];			
						_staticAiDescriptor params["_noGroupsToSpawn","_unitsPerGroup","_difficulty","_chance"];				
						private _spawns = [_areaDescriptor,[_noGroupsToSpawn] call GMSAI_getNumberFromRange,_players] call GMSAI_findRandomPosWithinArea;
						//diag_log format["[GMSAI] _Activating spawns at %1 in area %2",_spawns,_area];
						if !(_spawns isEqualTo []) then
						{
							{
								private _groupSpawnPos = _x;
								private _group = [_groupSpawnPos,[_unitsPerGroup] call GMSAI_getNumberFromRange,300] call GMSAI_spawnInfantryGroup;	
								_group setVariable["GMSAI_groupParameters",_staticAiDescriptor];
								_group setVariable["GMSAI_despawnDistance",GMSAI_staticDespawnDistance];
								_group setVariable["GMSAI_DespawnTime",GMSAI_staticDespawnTime];
								_group setVariable["GMSAI_patrolArea",[_groupSpawnPos,150,150]];
								diag_log format["[GMSAI] _monitorInactiveAreas: _group = %1",_group];
								private _m = "";
								if (GMSAI_debug > 1) then
								{
									_m = createMarker[format["GMSAI_dynamicMarker%1",random(1000000)],_groupSpawnPos];
									_m setMarkerType "mil_triangle";
									_m setMarkerColor "COLORRED";
									_m setMarkerPos _groupSpawnPos;
									_m setMarkerText format["%1:%2",_group,{alive _x} count units _group];
									diag_log format["[GMSAI] infantry group debug marker %1 created at %2",_m,markerPos _m];
								};
								GMSAI_infantryGroups pushBack [_group,_m,"",GMSAI_staticRespawnTime];
							} forEach _spawns;
						GMSAI_activeStaticSpawns pushBack  [_area,diag_tickTime];							
						} else {

						};
					} else {
						_area set [respawnAt,diag_tickTime + (GMSAI_staticRespawnTime/2)];
						GMSAI_StaticSpawns pushBack _area;
					};
				// Do something here to select locations for groups to be spawned and spawn them
				} else {
					GMSAI_StaticSpawns pushBack _area;
				};
			} else {
				// if the area passes a timestamp check the spawn more AI otherwise it should be checked again later.
				GMSAI_StaticSpawns pushBack _area;
			};
		};
	};
};