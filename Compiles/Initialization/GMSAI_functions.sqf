/*
	By Ghostrider [GRG]
	Copyright 2018
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/

{
	_x params ["_name","_path"];
	missionnamespace setvariable [_name,compileFinal  preprocessFileLineNumbers format["%1\%2.sqf",_path,_name]];
} forEach 
[
	["GMSAI_ConfigureStaticSpawnsForLocations","addons\GMSAI\Compiles\Initialization"],
	["GMSAI_ConfigureRandomSpawnLocations","addons\GMSAI\Compiles\Initialization"],
	["GMSAI_addStaticAISpawn","addons\GMSAI\Compiles\Functions"],
	["GMSAI_mainThread","addons\GMSAI\Compiles\Functions"],
	["GMSAI_monitorInactiveAreas","addons\GMSAI\Compiles\Functions"],
	["GMSAI_monitorActiveAreas","addons\GMSAI\Compiles\Functions"],
	["GMSAI_getNumberFromRange","addons\GMSAI\Compiles\Functions"],
	["GMSAI_dynamicAIManager","addons\GMSAI\Compiles\Functions"],
	["GMSAI_spawnInfantryGroup","addons\GMSAI\Compiles\Units"],
	["GMSAI_despawnInfantryGroup","addons\GMSAI\Compiles\Units"],
	["GMSAI_infantryGroupMonitor","addons\GMSAI\Compiles\Units"],	
	["GMSAI_findRandomPosWithinArea","addons\GMSAI\Compiles\Functions"]
];

diag_log "[GMSAI] Functions Compiled";