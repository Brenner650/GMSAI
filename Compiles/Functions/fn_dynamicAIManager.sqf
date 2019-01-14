/*
	ensure that dynamic AI are spawned and registered with the group MONITOR
	update timers as needed.
*/
#define GMSAI_dynamicSpawnDistance 250
#define GMSAI_dynamicDespawnDistance 400
//#define GMSAI_dynamicRespawnTime 600
//#define GMSAI_dynamicDespawnTime 120
#define GMSAI_alertAIDistance 300
//diag_log format["[GMSAI] running DYNAMIC AI MONITOR at %1 | count allPlayer = %2",diag_tickTime, count allPlayers];
//if (true) exitWith {};
{

	private _player = _x;	
	private _respawns = _player getVariable "GMSAI_dynamicAIRespawns";
	if (isNil "_respawns") then
	{
		_respawns = GMSAI_dynamicRespawns;
		_player setVariable ["GMSAI_dynamicAIRespawns",GMSAI_dynamicRespawns];
	};	
	//diag_log format["[GMSAI] _dynamicAIManger: evaluating player %1 with AI respawns of %2",_player,_respawns];		
 	if (_respawns == -1 || _respawns < GMSAI_dynamicRespawns) then
    {
		private _respawnAt = _player getVariable "GMSAI_dynamicRespawnAt";
		if (isNil "_respawnAt") then 
		{
			_player setVariable["GMSAI_dynamicRespawnAt",(diag_tickTime + GMSAI_dynamicRespawnTime)];
			_respawnAt = _player getVariable "GMSAI_dynamicRespawnAt";
		};
		//diag_log format["[GMSAI] _dynamicAIManger: _respawnAt = %1 | current time %2",_respawnAt,diag_tickTime];		
		//diag_log format["[GMSAI] _dynamicAIManger: _player GMSAI_dynamicRespawnAt = %1 at time %2",_player getVariable "GMSAI_dynamicRespawnAt",diag_tickTime];
		if (diag_tickTime >_respawnAt && (vehicle _player == _player)) then
		{
			//diag_log format["[GMSAI] _dynamicAIManger: spawn condition reached"];
			private _activePlayerGroup = _player getVariable "GMSAI_playerGroup";
			if (isNil "_activePlayerGroup") then  // 
			{
				if (random(1) < GMSAI_dynamicRandomChance) then
				{
					private _dynamicAI = _player nearEntities["Man",400] select {typeOf _x isEqualTo "I_G_Sharpshooter_F"};
					//diag_log format[" evaluating nearby units: _dynamicAIManger: _dynamicAI = %1",_dynamicAI];
					if (_dynamicAI isEqualTo []) then
					{
						private _spawnPos = (getPosATL _player) getPos[GMSAI_dynamicSpawnDistance,random(359)];	
						//diag_log format[" _dynamicAIManger: spawnPosition = %1",_spawnPos];	
						private _units = [GMSAI_dynamicRandomUnits] call GMS_fnc_getNumberFromRange;
						private _group = [_spawnPos,_units,GMSAI_alertAIDistance] call GMS_fnc_spawnInfantryGroup;	
						private _unitDifficulty = selectRandomWeighted GMSAI_dynamicUnitsDifficulty;
						[_group,GMSAI_unitDifficulty select (_unitDifficulty)] call GMS_fnc_setupGroupSkills;
						[_group, GMSAI_unitLoadouts select _unitDifficulty, GMSAI_staticLaunchersPerGroup, GMSAI_useNVG, GMSAI_blacklistedGear] call GMS_fnc_setupGroupGear;
						[_group,_unitDifficulty,GMSAI_money] call GMS_fnc_setupGroupMoney;
						[_group] call GMS_fnc_setupGroupBehavior;											
						_group setVariable["GMSAI_groupParameters",GMSAI_dynamicSettings];
						_group setVariable["GMSAI_despawnDistance",GMSAI_dynamicDespawnDistance];
						_group setVariable["GMSAI_DespawnTime",GMSAI_dynamicDespawnTime];
						//_group setVariable["GMSAI_respawnTime",GMSAI_dynamicRespawnTime];
						_group setVariable["GMSAI_patrolArea",[_spawnPos,150]];
						diag_log format["[GMSAI] _dynamicAIManger: _group = %1",_group];
						_player setVariable["GMSAI_playerGroup",_group];
						private _m = "";
						if (GMSAI_debug > 1) then
						{
							_m = createMarker[format["GMSAI_dynamicMarker%1",random(1000000)],_spawnPos];
							_m setMarkerType "mil_triangle";
							_m setMarkerColor "COLORRED";
							_m setMarkerPos _spawnPos;
							_m setMarkerText format["%1:%2",_group,{alive _x} count units _group];
							diag_log format["[GMSAI] infantry group debug marker %1 created at %2",_m,markerPos _m];
						};
						GMSAI_infantryGroups pushBack [_group,_m,_player,GMSAI_dynamicRespawnTime];
					};
				} else {
					_player setVariable["GMSAI_dynamicRespawnAt",diag_tickTime + (GMSAI_dynamicDespawnTime/2)];
				};
				
			};
			
		};
		
	};
} forEach allPlayers;