/*
	By Ghostrider [GRG]
	Copyright 2016
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.
*/
diag_log "[GMSAI] starting postInit";
if (!(isServer) || hasInterface) exitWith {diag_log "[GMSAI] ERROR: GMSAI SHOULD NOT BE RUN ON A CLIENT PC";};
if (!isNil "GMSAI_Initialized") exitWith {diag_log "[GMSAI] 	ERROR: GMSAI AREADY LOADED";};
//waitUntil {!isNil "blck_Initialized";};
//diag_log "[GMSAI] blckeagls mission system detected, loading GMSAI";
//#include "addons\GMSAI\Variables\defines.hpp";

call compileFinal preprocessFileLineNumbers "addons\GMSAI\Variables\GMSAI_Variables.sqf";
call compileFinal preprocessFileLineNumbers "addons\GMSAI\Configs\GMSAI_configs.sqf";
call compileFinal preprocessFileLineNumbers "addons\GMSAI\Compiles\Initialization\GMSAI_Functions.sqf";

private _staticLocationSpawns = [] call GMSAI_ConfigureStaticSpawnsForLocations;
//diag_log format["_staticLocationSpawns = %1",_staticLocationSpawns];
[_staticLocationSpawns] call GMSAI_ConfigureRandomSpawnLocations;
_staticLocationSpawns = nil;

if !( isNull (configFile >> "CfgPatches" >> "exile_server")) then {GMSAI_modType = "Exile"};
if !(isNull (configFile >> "CfgPatches" >> "a3_epoch_server")) then {GMSAI_modType = "Epoch"};

diag_log format["[_postInit: GMSAI_modType = %1",GMSAI_modType];
if (GMSAI_modType isEqualTo "Epoch") then 
{
	GMSAI_side = RESISTANCE;
};
if (GMSAI_modType isEqualTo "Exile") then
{
	GMSAI_side = EAST;
};
private _infantry = [];
/*
for "_i" from 1 to 10 do
{
	_pos = [nil,["water"]] call BIS_fnc_randomPos;
	_group = [_pos] call GMSAI_spawnInfantryGroup;
	_infantry pushBack _group;
};
uiSleep 10;
{
	{deleteVehicle _x} forEach units _x;
	deleteGroup _x;
}forEach _infantry;
*/
/*
diag_log "<<< --- TEST findRandomPosWithinArea";
for "_i" from 1 to 10 do {
	_randomMarker = selectRandom GMSAI_StaticSpawns;
	_randomPos = [_randomMarker select 0,3,allPlayers] call GMSAI_findRandomPosWithinArea;
	diag_log format["_preInit: _randomPos = %1 generate within _randomMarker of %2",_randomPos,_randomMarker];
};
*/

// Initialize roaming vehicle spawns
// Initialize roaming air patrol spawns
[] spawn GMSAI_mainThread;
diag_log format["GMSAI Initialized at %1",diag_tickTime];
true;