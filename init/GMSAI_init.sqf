#include "\addons\GMSAI\init\GMSAI_defines.hpp"
call compileFinal preprocessFileLineNumbers "addons\GMSAI\Variables\GMSAI_Variables.sqf";
call compileFinal preprocessFileLineNumbers "addons\GMSAI\Configs\GMSAI_configs.sqf";
private _staticLocationSpawns = [] call GMSAI_fnc_ConfigureStaticSpawnsForLocations;
[_staticLocationSpawns] call GMSAI_fnc_ConfigureRandomSpawnLocations;
_staticLocationSpawns = nil;
call GMSAI_fnc_initializeAircraftPatrols;
call GMSAI_fnc_initializeUAVPatrols;
[] spawn GMSAI_fnc_mainThread;
GMSAI_Initialized = true;

