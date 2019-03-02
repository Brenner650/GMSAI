#define GMSAI_dynamicSpawnDistance 200
#define GMSAI_dynamicDespawnDistance 400
#define GMSAI_alertAIDistance 300
diag_log format["[GMSAI] running DYNAMIC AI MONITOR at %1 | count allPlayer = %2 | GMSAI_useDynamicSpawns = %4 | GMSAI_maximumDynamicRespawns = %3",diag_tickTime, count allPlayers, GMSAI_maximumDynamicRespawns,GMSAI_useDynamicSpawns];
if (GMSAI_useDynamicSpawns) then
{
	{
		private _player = _x;	
		private _group = _player getVariable "GMSAI_Group";
		if !(isNil "_group") then // a group was spawned so lets evaluate it.
		{
			diag_log format["_dynamicAIManger: evaluating active group %1 for player %2",_group,_player];
			if (_group isEqualTo grpNull || {alive _x} count (units _group) == 0) then  
			{
				_player setVariable["GMSAI_Group",nil];
				_player setVariable["GMSAI_RespawnAt",(diag_tickTime + GMSAI_dynamicRespawnTime)];
				deleteMarkerLocal (_player getVariable "GMSAI_patrolAreaMarker");
				deleteMarker (_player getVariable["GMSAI_groupMarker",""]);
			} else {
				_lastChecked = _group getVariable "GMSAI_lastChecked";
				if (isNil "_lastChecked") then
				{
					_lastChecked = diag_tickTime;
					_group setVariable ["GMSAI_lastChecked",_lastChecked];
				} else {
					private _players = allPlayers inAreaArray [getPos (leader _group),GMSAI_dynamicDespawnDistance,GMSAI_dynamicDespawnDistance];
					if (_players isEqualTo []) then
					{
						if (diag_tickTime > (_lastChecked + GMSAI_dynamicDespawnTime)) then
						{
							[_group] call GMS_fnc_despawnInfantryGroup;
							_player setVariable["GMSAI_Group",nil];
							_player setVariable["GMSAI_RespawnAt",(diag_tickTime + GMSAI_dynamicRespawnTime)];
							if (GMSAI_debug > 1) then
							{
								deleteMarker (_player getVariable["GMSAI_groupMarker",""]);	
								deleteMarker (_player getVariable "GMSAI_patrolAreaMarker");
							} else {
								deleteMarkerLocal (_player getVariable "GMSAI_patrolAreaMarker");		
							};
						};
					} else {
						_group setVariable ["GMSAI_lastChecked",diag_tickTime];
						_m = _player getVariable "GMSAI_groupMarker";	
						if !(isNil _m) then
						{
							_m setMarkerPos (getPos(leader _group));
						};
					};
				};
			};
		} else {  // no dynamic AI group has been spawned, lets check if one should be
			private _respawns = _player getVariable "GMSAI_Respawns";
			if (isNil "_respawns") then
			{
				_respawns = 0;
				_player setVariable ["GMSAI_Respawns",0];
			};	
			private _respawnsAllowed = _player getVariable "GMSAI_maximumRespawns";
			if (isNil "_respawnsAllowed") then
			{
				_respawnsAllowed = GMSAI_maximumDynamicRespawns;
				_player setVariable["GMSAI_maximumRespawns",_respawnsAllowed];
			};
			diag_log format["_dynamicAIManger: no active dynamic group found for player %1, evaluating spawn parameters: _respawns = %2 | _respawnsAllowed = %3",_player,_respawns,_respawnsAllowed];			
			if (_respawnsAllowed == -1 || _respawns <= _respawnsAllowed) then
			{
				private _lastSpawnedAt = _player getVariable["GMSAI_LastSpawnedAt",0];
				private _respawnAt = _player getVariable "GMSAI_RespawnAt";
				if (isNil "_respawnAt") then 
				{
					_player setVariable["GMSAI_RespawnAt",(diag_tickTime + GMSAI_dynamicRespawnTime)];
					_respawnAt = _player getVariable "GMSAI_RespawnAt";
				};
				diag_log format["[GMSAI] _dynamicAIManger: _respawnAt = %1 | current time %2 | GMSAI_dynamicRespawnTime = %3",_respawnAt,diag_tickTime,GMSAI_dynamicRespawnTime];		
				if (diag_tickTime >_respawnAt && (vehicle _player == _player)) then
				{
					diag_log format["[GMSAI] _dynamicAIManger: spawn condition reached"];
					if (random(1) < GMSAI_dynamicRandomChance) then
					{
						private _dynamicAI = _player nearEntities["I_G_Sharpshooter_F",300];
						diag_log format[" evaluating nearby units: _dynamicAIManger: _dynamicAI = %1",_dynamicAI];
						if (_dynamicAI isEqualTo []) then  //  Only spawn dynamic AI if there are no other roamers around.
						{
							private _spawnPos = (getPosATL _player) getPos[GMSAI_dynamicSpawnDistance,random(359)];	
							diag_log format[" _dynamicAIManger: spawnPosition = %1",_spawnPos];	
							private _group = [_spawnPos,[GMSAI_dynamicRandomUnits] call GMS_fnc_getIntegerFromRange,GMSAI_alertAIDistance,GMSAI_useNVG,GMSAI_LaunchersPerGroup] call GMS_fnc_spawnInfantryGroup;	
							private _unitDifficulty = selectRandomWeighted GMSAI_dynamicUnitsDifficulty;
							[_group,GMSAI_unitDifficulty select (_unitDifficulty)] call GMS_fnc_setupGroupSkills;
							[_group, GMSAI_unitLoadouts select _unitDifficulty, GMSAI_LaunchersPerGroup, GMSAI_useNVG, GMSAI_blacklistedGear] call GMS_fnc_setupGroupGear;
							[_group,_unitDifficulty,GMSAI_money] call GMS_fnc_setupGroupMoney;
							[_group] call GMS_fnc_setupGroupBehavior;	
							_group setVariable["GMSAI_despawnDistance",GMSAI_dynamicDespawnDistance];
							_group setVariable["GMSAI_DespawnTime",GMSAI_dynamicDespawnTime];
							private _m = "";
							private _patrolArea = "";							
							if (GMSAI_debug > 1) then
							{
								_m = createMarker[format["GMSAI_dynamicMarker%1",random(1000000)],_spawnPos];
								_player setVariable["GMSAI_groupMarker",_m];
								_m setMarkerType "mil_triangle";
								_m setMarkerColor "COLORORANGE";
								_m setMarkerPos _spawnPos;
								_m setMarkerText format["%1:%2",_group,{alive _x} count units _group];
								_patrolArea = createMarker["GMSAI_dynamic%1",_group];
								_patrolArea setMarkerShape "RECTANGLE";
								_patrolArea setMarkerSize [GMSAI_dynamicSpawnDistance + 100,GMSAI_dynamicSpawnDistance + 100];								
								//diag_log format["[GMSAI] infantry group debug marker %1 created at %2",_m,markerPos _m];
							} else {
								_patrolArea = createMarkerLocal["GMSAI_dynamic%1",_group];
								_patrolArea setMarkerShapeLocal "RECTANGLE";
								_patrolArea setMarkerSizeLocal [GMSAI_dynamicSpawnDistance + 100,GMSAI_dynamicSpawnDistance + 100];
							};
							_group setVariable["GMSAI_patrolArea",_patrolArea];				
							_group reveal[_player,4];
							_group setVariable["GMSAI_target",_player];
							diag_log format["[GMSAI] _dynamicAIManger: _group = %1",_group];
							_group call GMSAI_fnc_initializeWaypointInfantry;
							[_group] call GMSAI_fnc_addEventHandlersInfantry;		
							_player setVariable["GMSAI_Group",_group];
							_player setVariable["GMSAI_patrolAreaMarker",_patrolArea];
							["dynamic","dynamic message"] call GMS_fnc_messagePlayers;
						};
					} else {
						_player setVariable["GMSAI_dynamicRespawnAt",diag_tickTime + (GMSAI_dynamicDespawnTime/2)];
					};	
				};
			};
		};
	} forEach allPlayers;
};
