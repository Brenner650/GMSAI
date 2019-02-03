/*
	By Ghostrider [GRG]
	Copyright 2016
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
class GMSAAI_Build {
	build = 0.1;
	buildDate = "2-2-19";
};
class CfgPatches {
	class GMSAI {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"GMSCore"};
	};
};
class CfgFunctions {
	class GMSAI {
		class main {
			file = "addons\GMSAI\init";
			class initialize {
				postInit = 1;
			};
		};
		class Players {
			file = "addons\GMSAI\Compiles\Players";
			class rewardPlayer {};
		};
		class Units {
			file = "addons\GMSAI\Compiles\Units";
			class infantryGroupMonitor {};
			class nextWaypoint {};
			class initializeWaypointInfantry {};
			class EH_MPInfantryKilled {};
			class EH_MPInfantryHit {};
			class processInfantryKilled {};
			class processInfantryHit {};
			class monitorInfantryGroups {};
			class addEventHandlersInfantry {};
		};
		class Vehicles {
			file = "addons\GMSAI\Compiles\Vehicles";
			class monitorAirPatrols {};
			class spawnHelicoptorPatrol {};
			class initializeAircraftPatrols {};
			class nextWaypointAircraft {};
			class EH_crewKilled {};
			class processAircraftCrewKilled {};
		};
		class Initialization {
			file = "addons\GMSAI\Compiles\Initialization";
			class ConfigureStaticSpawnsForLocations {};
			class ConfigureRandomSpawnLocations {};
		};
		class Functions {
			file = "addons\GMSAI\Compiles\Functions";
			class addStaticSpawn {};
			class dynamicAIManager {};
			class mainThread {};
			class monitorActiveAreas {};
			class monitorInactiveAreas {};
			//class checkClassnames {};
		};
	};
};
