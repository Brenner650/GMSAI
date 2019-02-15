#include "\addons\GMSAI\init\GMSAI_defines.hpp"
//waitUntil {GMSCoreInitialized};
call compileFinal preprocessFileLineNumbers "addons\GMSAI\Variables\GMSAI_Variables.sqf";
call compileFinal preprocessFileLineNumbers "addons\GMSAI\Configs\GMSAI_configs.sqf";
private _staticLocationSpawns = [] call GMSAI_fnc_ConfigureStaticSpawnsForLocations;
[_staticLocationSpawns] call GMSAI_fnc_ConfigureRandomSpawnLocations;
_staticLocationSpawns = nil;
call GMSAI_fnc_initializeAircraftPatrols;
[] spawn GMSAI_fnc_mainThread;
GMSAI_Initialized = true;


/*
private _spawnPos = [10000,11000,0];
private _units = 1;
private _group = [_spawnPos,_units,300,GMSAI_useNVG,GMSAI_LaunchersPerGroup] call GMS_fnc_spawnInfantryGroup;	
private _unitDifficulty = selectRandomWeighted GMSAI_dynamicUnitsDifficulty;
[_group,GMSAI_unitDifficulty select (_unitDifficulty)] call GMS_fnc_setupGroupSkills;
[_group, GMSAI_unitLoadouts select _unitDifficulty, GMSAI_LaunchersPerGroup, GMSAI_useNVG, GMSAI_blacklistedGear] call GMS_fnc_setupGroupGear;
[_group,_unitDifficulty,GMSAI_money] call GMS_fnc_setupGroupMoney;
[_group] call GMS_fnc_setupGroupBehavior;	
_group setVariable["GMSAI_groupParameters",GMSAI_dynamicSettings];
_group setVariable["GMSAI_despawnDistance",500];
_group setVariable["GMSAI_DespawnTime",120];
//_group setVariable["GMSAI_respawnTime",GMSAI_dynamicRespawnTime];
private _m = createMarker[format["DynamicInfantryGroup%1",_group],_spawnPos];
_m setMarkerShapeLocal "RECTANGLE";
_m setMarkerSizeLocal [150,150];
_group setVariable["GMSAI_patrolArea",_m];
_group setVariable["GMSAI_waypointSpeed","NORMAL"];
_group setVariable["GMSAI_waypointLoiterRadius",30];	
_group setVariable["GMSAI_blacklistedAreas",["water"]];											

diag_log format["[GMSAI] _initialization: _group = %1",_group];
_group call GMSAI_fnc_initializeWaypointInfantry;
[_group] call GMSAI_fnc_addEventHandlersInfantry;		
//_player setVariable["GMSAI_playerGroup",_group];
//diag_log "[GMSAI] GMSAI_init.sqf completed";
private _m = "";

if (GMSAI_debug > 1) then
{
	_m = createMarker[format["GMSAI_dynamicMarker%1",random(1000000)],_spawnPos];
	_m setMarkerType "mil_triangle";
	_m setMarkerColor "COLORRED";
	_m setMarkerPos _spawnPos;
	_m setMarkerText format["%1:%2",_group,{alive _x} count units _group];
	diag_log format["[GMSAI-Initialization] infantry group debug marker %1 created at %2",_m,markerPos _m];
};
GMSAI_infantryGroups pushBack [_group,_m,_player,GMSAI_dynamicRespawnTime];