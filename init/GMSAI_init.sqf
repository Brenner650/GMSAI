//waitUntil {GMSCoreInitialized};
call compileFinal preprocessFileLineNumbers "addons\GMSAI\Variables\GMSAI_Variables.sqf";
call compileFinal preprocessFileLineNumbers "addons\GMSAI\Configs\GMSAI_configs.sqf";
private _staticLocationSpawns = [] call GMSAI_fnc_ConfigureStaticSpawnsForLocations;
[_staticLocationSpawns] call GMSAI_fnc_ConfigureRandomSpawnLocations;
_staticLocationSpawns = nil;
[] spawn GMSAI_fnc_mainThread;
diag_log "[GMSAI] GMSAI_init.sqf completed";