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
			class ConfigureStaticSpawnsForLocations {};
			class ConfigureRandomSpawnLocations {};		
			class EH_InfantryKilled {};
			class EH_InfantryHit {};
			class EH_infantryReloaded {};				
			class infantryGroupMonitor {};
			class initializeWaypointInfantry {};
			class monitorActiveAreas {};
			class monitorInactiveAreas {};			
			class monitorInfantryGroups {};
			class monitorDeadUnits {};			
			class nextWaypointInfantry {};			
			class processInfantryKill {};
			class processUnitKill {};
			class processInfantryHit {};
			class addEventHandlersInfantry {};
		};
		class Vehicles {
			file = "addons\GMSAI\Compiles\Vehicles";
			class EH_crewHitHeli {};
			class EH_crewHitVehicle {};
			class EH_crewKilledHeli {};
			class EH_crewKilledVehicle {};
			class EH_crewGetOut {};
			class EH_aircraftHit {};
			class EH_vehicleHit {};
			class flyInParatroops {};
			class initializeAircraftPatrols {};
			class initializeVehiclePatrols {};
			class nextWaypointVehicles {};
			class loiterWaypointVehicles {};
			class monitorVehiclePatrols {};
			class initializeUAVPatrols {};			
			class monitorEmptyVehicles {};
			class monitorAirPatrols {};  
			class monitorUAVPatrols {};			
			class nextWaypointAircraft {};			
			class processAircraftCrewHit {};
			class processAircraftCrewKill {};
			class processVehicleCrewHit {};
			class processVehicleCrewKill {};
			class processCrewGetoutEvent {};
			class processEmptyVehicle {};						
			class processAircraftHit {};
			class processVehicleHit {};
			class spawnHelicoptorPatrol {};		
			class spawnVehiclePatrol {};	
			class spawnParatroops {};
			class spawnUAVPatrol {};
		};
		class Initialization {
			file = "addons\GMSAI\Compiles\Initialization";

		};
		class Functions {
			file = "addons\GMSAI\Compiles\Functions";
			class addStaticSpawn {};
			class dynamicAIManager {};
			class mainThread {};

			//class checkClassnames {};
		};
	};
};
//#include "$PBOPREFIX$\addons\GMSAI\Configs\config.cpp"