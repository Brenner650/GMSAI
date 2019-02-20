/*
	By Ghostrider [GRG]
	Copyright 2018
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#define GMSAI_difficultyBlue 0
#define GMSAI_difficultyRed 1
#define GMSAI_difficultyGreen 2
#define GMSAI_difficultyOrange 3

/*********************************
	 Messaging to Clients
*********************************/
GMSAI_useKillMessages = true;
GMSAI_useKilledAIName = true; // when true, the name of the unit killed will be included in the kill message.
/*********************************
	 Patrol Spawn Configs
*********************************/

GMSAI_releaseVehiclesToPlayers = 1;  // set to -1 to disable this feature.
GMSAI_vehicleDeleteTimer = 600; // vehicles with no live crew will be deleted at this interval after all crew are killed.

GMSAI_checkClassNames = true; // when true, class names listed in the configs will be checked against CfgVehicles, CfgWeapons, ets.
GMSAI_useCfgPricingForLoadouts = true;
GMSAI_maxPricePerItem = 1000;
GMSAI_blacklistedGear = [];
GMSAI_blackListedAreas = [
	[[0,0,0],100]
]; // Ady any areas you want excluded from searches for waypoints.
/*********************************
	Aircraft Patrol Spawn Configs
*********************************/
GMSAI_numberOfAircraftPatrols = 5;
GMSAI_aircraftPatrolDifficulty =  [GMSAI_difficultyBlue,0.90,GMSAI_difficultyRed,0.10];
GMSAI_aircraftRespawnTime = 900;
GMSAI_aircraftChanceOfParatroops = 0.9999;  // Chance that detection of enemy players will trigger paratroopers
GMSAI_aircraftGunners = 3;
GMSAI_airpatrolResapwns = -1;
// treat aircraft types as weighted arrayIntersect
GMSAI_aircraftTypes = [
		"B_Heli_Transport_01_F",5,
		"B_Heli_Light_01_F",1,
		"I_Heli_light_03_unarmed_F",5,
		"B_Heli_Transport_03_unarmed_green_F",5,
		"I_Heli_light_03_F",1,
		"I_Plane_Fighter_03_AA_F",1,
		"O_Heli_Light_02_F",2,
		"B_Heli_Attack_01_F",2,
		"B_Heli_Transport_03_unarmed_F",5
];

GMSAI_numberOfUAVPatrols = 5;
GMSAI_UAVTypes = ["I_UAV_01_F",1];
GMSAI_UAVDifficulty = [GMSAI_difficultyBlue,0.40,GMSAI_difficultyRed,0.40,GMSAI_difficultyGreen,0.15,GMSAI_difficultyOrange,0.05];
GMSAI_UAVRespawnTime = 900;
GMSAI_UAVChanceOfPParatroops = 0.99999; // Chance that detection of enemy players will trigger paratroopers

GMSAI_oddsParatroops = 0.5;
GMSAI_numberParatroops = [2,4]; // can be a single value (1, [1]) or a range
GMSAI_paratroopDifficulty = [GMSAI_difficultyBlue,0.40,GMSAI_difficultyRed,0.40,GMSAI_difficultyGreen,0.15,GMSAI_difficultyOrange,0.05];
GMSAI_paratroopRespawnTimer = 900;
GMSAI_paratroopAircraftTypes = [  // Note: this is a weighted array of vehicles used to carry paratroops in to locations spotted by UAVs or UGVs
		"B_Heli_Transport_01_F",5,
		"B_Heli_Light_01_F",1,
		"I_Heli_light_03_unarmed_F",5,
		"B_Heli_Transport_03_unarmed_green_F",5,
		"I_Heli_light_03_F",1,
		"O_Heli_Light_02_F",2,
		"B_Heli_Transport_03_unarmed_F",5
];

GMSAI_noVehiclePatrols = 5;
GMSAI_patroVehicleCrewCount = [2,4];
GMSAI_vehiclePatroDifficulty = [GMSAI_difficultyBlue,0.40,GMSAI_difficultyRed,0.40,GMSAI_difficultyGreen,0.15,GMSAI_difficultyOrange,0.05];
GMSAI_vehiclePatrolDeleteTime = 600;
GMSAI_vehiclePatrolRespawnTime = 600;
GMSAI_vehiclePatrolRespawns = -1;
GMSAI_blackListedAreasVehicles = []; //  List location names or coordinates/radius to which vehicles should not be sent. They may still pass through but will not patrol there.
GMSAI_patrolVehicles = [  // Weighted array of vehicles spawned to patrol roads and cities.
	"C_Offroad_01_F",1
];

GMSAI_blacklistedTurrets = [];
/*********************************
	Static Infantry Spawn Configs
*********************************/
GMSAI_LaunchersPerGroup = 1; // set to -1 to disable
GMSAI_launcherCleanup = true;
GMSAI_useNVG = true;
GMSAI_removeNVG = false;
GMSAI_runoverProtection = true;
GMSAI_bodyDeleteTimer = 600;
//GMSAI_blacklistedAreasInfantry = GMSAI_blackListedAreas + [ [1,1,1],100];  //  add these as [position, radius]. Add trader locations or other areas to which you do not want AI moving.

//GMSAI_StaticSpawnAtLocations = false;
//GMSAI_StaticSpawnsGrid = true;  // does nothing at present
GMSAI_useStaticSpawns = true;
GMSAI_staticRespawns = -1;  //  Set to -1 to have infinite respawns.
GMSAI_staticRespawnTime = 600;
GMSAI_staticDespawnTime = 120;
GMSAI_StaticSpawnsRandom = 15;  // Determines the number of random spans independent of cites, town, military areas, ports, airports and other:  default 25

// 
GMSAI_useDynamicSpawns = true;
GMSAI_dynamicRespawns = -1;  //  Set to 0 to disable, or -1 to have infinite respawns.
GMSAI_dynamicRespawnTime = 30;
GMSAI_dynamicDespawnTime = 10;
GMSAI_dynamicUnitsDifficulty = [GMSAI_difficultyBlue,0.90,GMSAI_difficultyRed,0.10];
GMSAI_dynamicRandomGroups = [1];
GMSAI_dynamicRandomUnits = [3];
GMSAI_dynamicRandomChance = 0.50;

GMSAI_staticVillageGroups = 1;
GMSAI_staticVillageUnitsPerGroup = [1,3];
// Difficulties are specified using a weighted array. Any number of options is available. The total relative chance does NOT have to add up to 1, but does specify the relative chance an option will be chosen.
GMSAI_staticVillageUnitsDifficulty = [GMSAI_difficultyBlue,0.90,GMSAI_difficultyRed,0.10]; // the value after each difficulty level indicates the relative chance it will be selected from the weighted array.
GMSAI_ChanceStaticVillageGroups = 0.45;

GMSAI_staticCityGroups = 2;
GMSAI_staticCityUnitsPerGroup = [2,4];
GMSAI_staticCityUnitsDifficulty = [GMSAI_difficultyRed,1];
GMSAI_ChanceStaticCityGroups = 0.50;

GMSAI_staticCapitalGroups = [2,3];
GMSAI_staticCapitalUnitsPerGroup = [2,4];
GMSAI_staticCapitalUnitsDifficulty = [GMSAI_difficultyRed,0.50,GMSAI_difficultyGreen,0.50];
GMSAI_ChanceCapitalGroups = 0.75;

GMSAI_staticMarineGroups = [1];
GMSAI_staticMarineUnitsPerGroup = [2,3];
GMSAI_staticMarineUnitsDifficulty = [GMSAI_difficultyBlue,1];
GMSAI_ChanceStaticMarineUnits = 0.30;

GMSAI_staticOtherGroups = [1,2];
GMSAI_staticOtherUnitsPerGroup = [2,3];
GMSAI_staticOtherUnitsDifficulty = [GMSAI_difficultyRed,0.50,GMSAI_difficultyGreen,0.50];
GMSAI_ChanceStaticOtherGroups = 0.45;

GMSAI_staticRandomGroups = [1];
GMSAI_staticRandomUnits = [3];
GMSAI_staticRandomUnitsDifficulty = [GMSAI_difficultyBlue,0.75,GMSAI_difficultyRed,0.25];
GMSAI_staticRandomChance = 0.50;


/********************************************/

/*
	AI configs

*/
GMSAI_useNVG = true;
GMSAI_skillBlue = [ 
	// _skills params["_accuracy","_aimingSpeed","_shake","_spotDistance","_spotTime","_courage","_reloadSpeed","_commanding","_general"];
	0.15,  // accuracy
	0.15,  // aiming speed
	0.15, // aiming shake
	0.50, // spot distance
	0.50, // spot time
	0.50, // couraget
	0.50, // reload speed
	0.75, // commandingMenu
	0.70 // general, affects decision making
];
GMSAI_skillRed = [ 
	// _skills params["_accuracy","_aimingSpeed","_shake","_spotDistance","_spotTime","_courage","_reloadSpeed","_commanding","_general"];
	0.20,  // accuracy
	0.20,  // aiming speed
	0.25, // aiming shake
	0.60, // spot distance
	0.60, // spot time
	0.60, // couraget
	0.60, // reload speed
	0.75, // commandingMenu
	0.70 // general, affects decision making
];
GMSAI_skillGreen = [ 
	// _skills params["_accuracy","_aimingSpeed","_shake","_spotDistance","_spotTime","_courage","_reloadSpeed","_commanding","_general"];
	0.25,  // accuracy
	0.25,  // aiming speed
	0.25, // aiming shake
	0.70, // spot distance
	0.70, // spot time
	0.70, // couraget
	0.70, // reload speed
	0.75, // commandingMenu
	0.70 // general, affects decision making
];
GMSAI_skillOrange = [ 
	// _skills params["_accuracy","_aimingSpeed","_shake","_spotDistance","_spotTime","_courage","_reloadSpeed","_commanding","_general"];
	0.30,  // accuracy
	0.30,  // aiming speed
	0.30, // aiming shake
	0.80, // spot distance
	0.80, // spot time
	0.80, // couraget
	0.80, // reload speed
	0.75, // commandingMenu
	0.70 // general, affects decision making
];

/******************************************************************************************************************************************************* */
if (toLower(GMS_modType) isEqualTo "epoch") then {call compileFinal preprocessFileLineNumbers "addons\GMSAI\Configs\GMSAI_unitLoadoutEpoch.sqf"};
if (toLower(GMS_modType) isEqualTo "exile") then {call compileFinal preprocessFileLineNumbers "addons\GMSAI\Configs\GMSAI_unitLoadoutExile.sqf"};

/*
if (GMSAI_useConfigsBasedGearConfiguration) then
{
	// pull data from the CfgPricing or CfgArsenal configs - 
	// needs work to load the food, beverage, toos, and medical items
	// For now uses the defaults in the mod-specific configs
	private _gear = call GMS_fnc_dynamicConfigs;
	#define GMS_primary 0
	#define GMS_secondary 1
	#define GMS_throwable 2
	#define GMS_headgear 3
	#define GMS_uniforms 4
	#define GMS_vests 5
	#define GMS_backpacks 6
	#define GMS_items 7
	#define GMS_launchers 8;

	{
		private _gearArray = _x;
		_gearArray set[GMS_primary, _gear select GMS_primary];
		_gearArray set[GMS_secondary, _gear select GMS_secondary];
		_gearArray set[GMS_headgear, _gear select GMS_headgear];
		_gearArray set[GMS_uniforms, _gear select GMS_uniforms];
		_gearArray set[GMS_vests, _gear select GMS_vests];
		_gearArray set[GMS_backpacks, _gear select GMS_backpacks];
		//_items = [_gear select GMS_items select 0,_gear select GMS_items select 1;
		//_gearArray set[GMS_items,_items];
	} forEach [GMSAI_gearBlue,GMSAI_gearRed,GMSAI_gearGreen,GMSAI_gearOrange];
};
*/
/*
GMSAI_gearBlue = [
	[], // primary weapons
	[], // secondary weapons
	[], // throwables
	[], // headgear
	[], // uniformItems
	[], // vestItems
	[], // backpacks
	[], // items and equipment
	[] // launchers
];
*/
/****************************************************************************************************************************************************** */

GMSAI_unitDifficulty = [GMSAI_skillBlue, GMSAI_skillRed, GMSAI_skillGreen, GMSAI_skillOrange];
GMSAI_unitLoadouts = [GMSAI_gearBlue, GMSAI_gearRed, GMSAI_gearGreen, GMSAI_gearOrange];
GMSAI_staticVillageSettings = [GMSAI_staticCityGroups,GMSAI_staticVillageUnitsPerGroup,GMSAI_staticVillageUnitsDifficulty,GMSAI_ChanceStaticCityGroups];
GMSAI_staticCitySettings = [GMSAI_staticCityGroups,GMSAI_staticCityUnitsPerGroup,GMSAI_staticCityUnitsDifficulty,GMSAI_ChanceStaticCityGroups];
GMSAI_staticCapitalSettings = [GMSAI_staticCapitalGroups,GMSAI_staticCapitalUnitsPerGroup,GMSAI_staticCapitalUnitsDifficulty,GMSAI_ChanceCapitalGroups];
GMSAI_staticMarineSettings = [GMSAI_staticMarineGroups,GMSAI_staticMarineUnitsPerGroup,GMSAI_staticMarineUnitsDifficulty,GMSAI_ChanceStaticMarineUnits];
GMSAI_staticOtherSettings = [GMSAI_staticOtherGroups,GMSAI_staticOtherUnitsPerGroup,GMSAI_staticOtherUnitsDifficulty,GMSAI_ChanceStaticOtherGroups];
GMSAI_staticRandomSettings = [GMSAI_staticRandomGroups,GMSAI_staticRandomUnits,GMSAI_staticRandomUnitsDifficulty,GMSAI_staticRandomChance];
GMSAI_dynamicSettings = [GMSAI_dynamicRandomGroups,GMSAI_dynamicRandomUnits,GMSAI_dynamicUnitsDifficulty,GMSAI_dynamicRandomChance];


