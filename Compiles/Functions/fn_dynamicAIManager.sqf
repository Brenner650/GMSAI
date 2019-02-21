/*
	ensure that dynamic AI are spawned and registered with the group MONITOR
	update timers as needed.
*/
#define GMSAI_dynamicSpawnDistance 200
#define GMSAI_dynamicDespawnDistance 400
#define GMSAI_alertAIDistance 300
diag_log format["[GMSAI] running DYNAMIC AI MONITOR at %1 | count allPlayer = %2 | GMSAI_useDynamicSpawns = %4 | GMSAI_dynamicRespawns = %3",diag_tickTime, count allPlayers, GMSAI_dynamicRespawns,GMSAI_useDynamicSpawns];
if (GMSAI_useDynamicSpawns) then
{
	{
		private _player = _x;	
		if !(isNil (_player getVariable "GMSAI_dynamicAIGroup")) then // a group was spawned so lets evaluate it.
		{
			private _activeGroup =  _player getVariable "GMSAI_dynamicAIGroup";
			if (_activeGroup isEqualTo grpNull || {alive _x} count (units _activeGroup) == 0) then  
			{
				_player setVariable["GMSAI_dynamicAIGroup",nil];
				_player setVariable["GMSAI_dynamicRespawnAt",(diag_tickTime + GMSAI_dynamicRespawnTime)];
				deleteMarker _player getVariable "GMSAI_groupMarker";
			};
		} else {  // no dynamic AI group has been spawned, lets check if one should be
			private _respawns = _player getVariable "GMSAI_dynamicAIRespawns";
			if (isNil "_respawns") then
			{
				_respawns = GMSAI_dynamicRespawns;
				_player setVariable ["GMSAI_dynamicAIRespawns",GMSAI_dynamicRespawns];
			};	
			private _lastSpawnedAt = _player getVariable["dynamicAILastSpawnedAt",0];

			diag_log format["[GMSAI] _dynamicAIManger: evaluating player %1 with AI respawns of %2 and GMSAI_dynamicRespawns of %3",_player,_respawns,GMSAI_dynamicRespawns];		
			if (_respawns == -1 || _respawns < GMSAI_dynamicRespawns) then
			{
				private _respawnAt = _player getVariable "GMSAI_dynamicRespawnAt";
				if (isNil "_respawnAt") then 
				{
					_player setVariable["GMSAI_dynamicRespawnAt",(diag_tickTime + GMSAI_dynamicRespawnTime)];
					_respawnAt = _player getVariable "GMSAI_dynamicRespawnAt";
				};
				private _respawns = _player getVariable "GMSAI_dynamicRespawns";
				if (isNil "respawn") then
				{
					_player setVariable["GMSAI_dynamicRespawns",0];
					_respawns = 0;
				};
				diag_log format["[GMSAI] _dynamicAIManger: _respawnAt = %1 | current time %2",_respawnAt,diag_tickTime];		
				diag_log format["[GMSAI] _dynamicAIManger: _player GMSAI_dynamicRespawnAt = %1 at time %2",_player getVariable "GMSAI_dynamicRespawnAt",diag_tickTime];
				if (diag_tickTime >_respawnAt && (vehicle _player == _player) && (_respawns == -1 || _respawns <= GMSAI_dynamicRespawns)) then
				{
					diag_log format["[GMSAI] _dynamicAIManger: spawn condition reached"];
						
						if (random(1) < GMSAI_dynamicRandomChance) then
						{
							//private _dynamicAI = _player nearEntities["Man",400] select {typeOf _x isEqualTo "I_G_Sharpshooter_F"};
							private _dynamicAI = _player nearEntities["I_G_Sharpshooter_F",300];
							diag_log format[" evaluating nearby units: _dynamicAIManger: _dynamicAI = %1",_dynamicAI];
							if (_dynamicAI isEqualTo []) then
							{
								private _spawnPos = (getPosATL _player) getPos[GMSAI_dynamicSpawnDistance,random(359)];	
								diag_log format[" _dynamicAIManger: spawnPosition = %1",_spawnPos];	

								//private _units = [GMSAI_dynamicRandomUnits] call GMS_fnc_getIntegerFromRange;
								private _group = [_spawnPos,[GMSAI_dynamicRandomUnits] call GMS_fnc_getIntegerFromRange,GMSAI_alertAIDistance,GMSAI_useNVG,GMSAI_LaunchersPerGroup] call GMS_fnc_spawnInfantryGroup;	
								private _unitDifficulty = selectRandomWeighted GMSAI_dynamicUnitsDifficulty;
								[_group,GMSAI_unitDifficulty select (_unitDifficulty)] call GMS_fnc_setupGroupSkills;
								[_group, GMSAI_unitLoadouts select _unitDifficulty, GMSAI_LaunchersPerGroup, GMSAI_useNVG, GMSAI_blacklistedGear] call GMS_fnc_setupGroupGear;
								[_group,_unitDifficulty,GMSAI_money] call GMS_fnc_setupGroupMoney;
								[_group] call GMS_fnc_setupGroupBehavior;	
								_group setVariable["GMSAI_groupParameters",GMSAI_dynamicSettings];
								_group setVariable["GMSAI_despawnDistance",GMSAI_dynamicDespawnDistance];
								_group setVariable["GMSAI_DespawnTime",GMSAI_dynamicDespawnTime];
								
								//_group setVariable["GMSAI_respawnTime",GMSAI_dynamicRespawnTime];
								private _m = createMarker[format["DynamicInfantryGroup%1",_group],_spawnPos];
								_m setMarkerShapeLocal "RECTANGLE";
								_m setMarkerSizeLocal [150,150];
								_group setVariable["GMSAI_patrolArea",_m];
								_group setVariable["GMSAI_waypointSpeed","NORMAL"];
								_group setVariable["GMSAI_waypointLoiterRadius",30];	
								_group setVariable["GMSAI_blacklistedAreas",["water"]];											
								_group reveal[_player,1];
								diag_log format["[GMSAI] _dynamicAIManger: _group = %1",_group];
								_group call GMSAI_fnc_initializeWaypointInfantry;
								{
									_x addMPEventHandler["MPKilled",{this call GMSA__fnc_EH_InfantryKilled;}];
									_x addMPEventHandler["MPHit",{this call GMSAI_fnc_EH_InfantryHit;}];
									_x addEventHandler["Reloaded",{this call GMSAI_fnc_EH_InfantryReloaded;}];
								} forEach (units _group);		
								_player setVariable["GMSAI_dynamicAIGroup",_group];
								
								if (GMSAI_debug > 1) then
								{
									_m = createMarker[format["GMSAI_dynamicMarker%1",random(1000000)],_spawnPos];
									_player setVariable["GMSAI_groupMarker",_m];
									_group setVariable["GMSAI_groupMarker",_m];
									_m setMarkerType "mil_triangle";
									_m setMarkerColor "COLORRED";
									_m setMarkerPos _spawnPos;
									_m setMarkerText format["%1:%2",_group,{alive _x} count units _group];
									//diag_log format["[GMSAI] infantry group debug marker %1 created at %2",_m,markerPos _m];
								};
								GMSAI_infantryGroups pushBack [_group,_m];
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

/*
	Possible conditions
	1. a group was spawned and 1 or units is alive
		GMSAI_dynamicAIGroup != nil;  GMSAI_dynamicAIGroup != grpNull
		-> Do nothing 
	2. group was spawned and all units are dead; group may be == grpNull 
		-> set GMSAI_dynamicAIGroup to nil