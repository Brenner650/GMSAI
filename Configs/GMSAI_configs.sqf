/*
	By Ghostrider [GRG]
	Copyright 2018
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/

/*********************************
	Static Spawn Configs
*********************************/
//GMSAI_StaticSpawnAtLocations = false;
//GMSAI_StaticSpawnsGrid = true;  // does nothing at present
GMSAI_StaticSpawnsRandom = 10;  // default 25
GMSAI_useStaticSpawns = true;
GMSAI_staticRespawns = -1;  //  Set to 0 to disable, or -1 to have infinite respawns.
GMSAI_staticRespawnTime = 60;
GMSAI_staticDespawnTime = 30;
// 
//GMSAI_DynamicSpawns = false;
GMSAI_dynamicRespawns = 0;  //  Set to 0 to disable, or -1 to have infinite respawns.
GMSAI_dynamicRespawnTime = 600;
GMSAI_dynamicDespawnTime = 120;

GMSAI_staticVillageGroups = 1;
GMSAI_staticVillageUnitsPerGroup = [1,3];
GMSAI_staticVillageUnitsDifficulty = "blue";
GMSAI_ChanceStaticVillageGroups = 0.45;

GMSAI_staticCityGroups = 2;
GMSAI_staticCityUnitsPerGroup = [2,4];
GMSAI_staticCityUnitsDifficulty = "red";
GMSAI_ChanceStaticCityGroups = 0.50;

GMSAI_staticCapitalGroups = [2,3];
GMSAI_staticCapitalUnitsPerGroup = [2,4];
GMSAI_staticCapitalUnitsDifficulty = "green";
GMSAI_ChanceCapitalGroups = 0.75;

GMSAI_staticMarineGroups = [1];
GMSAI_staticMarineUnitsPerGroup = [2,3];
GMSAI_staticMarineUnitsDifficulty = "blue";
GMSAI_ChanceStaticMarineUnits = 0.30;

GMSAI_staticOtherGroups = [1,2];
GMSAI_staticOtherUnitsPerGroup = [2,3];
GMSAI_staticOtherUnitsDifficulty = "red";
GMSAI_ChanceStaticOtherGroups = 0.45;

GMSAI_staticRandomGroups = [1];
GMSAI_staticRandomUnits = [3];
GMSAI_staticRandomUnitsDifficulty = "red";
GMSAI_staticRandomChance = 0.50;

GMSAI_dynamicRandomGroups = [1];
GMSAI_dynamicRandomUnits = [3];
GMSAI_dynamicRandomDifficulty = "blue";
GMSAI_dynamicRandomChance = 0.50;
/********************************************/

/*
	AI configs

*/
GMSAI_staticVillageSettings = [GMSAI_staticCityGroups,GMSAI_staticVillageUnitsPerGroup,GMSAI_staticVillageUnitsDifficulty,GMSAI_ChanceStaticCityGroups];
GMSAI_staticCitySettings = [GMSAI_staticCityGroups,GMSAI_staticCityUnitsPerGroup,GMSAI_staticCityUnitsDifficulty,GMSAI_ChanceStaticCityGroups];
GMSAI_staticCapitalSettings = [GMSAI_staticCapitalGroups,GMSAI_staticCapitalUnitsPerGroup,GMSAI_staticCapitalUnitsDifficulty,GMSAI_ChanceCapitalGroups];
GMSAI_staticMarineSettings = [GMSAI_staticMarineGroups,GMSAI_staticMarineUnitsPerGroup,GMSAI_staticMarineUnitsDifficulty,GMSAI_ChanceStaticMarineUnits];
GMSAI_staticOtherSettings = [GMSAI_staticOtherGroups,GMSAI_staticOtherUnitsPerGroup,GMSAI_staticOtherUnitsDifficulty,GMSAI_ChanceStaticOtherGroups];
GMSAI_staticRandomSettings = [GMSAI_staticRandomGroups,GMSAI_staticRandomUnits,GMSAI_staticRandomUnitsDifficulty,GMSAI_staticRandomChance];
GMSAI_dynamicSettings = [GMSAI_dynamicRandomGroups,GMSAI_dynamicRandomUnits,GMSAI_dynamicRandomDifficulty,GMSAI_dynamicRandomChance];


