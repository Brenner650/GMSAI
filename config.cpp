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
			class EH_InfantryKilled {};
			class EH_InfantryHit {};
			class EH_infantryReloaded {};				
			class initializeWaypointInfantry {};
			class nextWaypointInfantry {};			
			class processInfantryKill {};
			class processUnitKill {};
			class processInfantryHit {};
			class addEventHandlersInfantry {};
		};
		class AirVehicles {
			file = "addons\GMSAI\Compiles\AirVehicles";
			class EH_crewHitHeli {};	
			class EH_crewKilledHeli {};		
			class EH_aircraftHit {};	
			class flyInParatroops {};			
			class nextWaypointAircraft {};			
			class processAircraftCrewHit {};
			class processAircraftCrewKill {};	
			class processAircraftHit {};		
			class spawnParatroops {};
			class spawnUAVPatrol {};	
			class spawnHelicoptorPatrol {};															
		};
		class LandVehicles {
			file = "addons\GMSAI\Compiles\LandVehicles";
			class EH_crewHitVehicle {};
			class EH_crewKilledVehicle {};
			class EH_crewGetOut {};
			class EH_vehicleHit {};
			class nextWaypointVehicles {};
			class loiterWaypointVehicles {};
			class processVehicleCrewHit {};
			class processVehicleCrewKill {};
			class processCrewGetoutEvent {};
			class processEmptyVehicle {};						
			class processVehicleHit {};
			class spawnVehiclePatrol {};	
		};
		class Initialization {
			file = "addons\GMSAI\Compiles\Initialization";
			class initializeStaticSpawnsForLocations {};
			class initializeRandomSpawnLocations {};				
			class initializeAircraftPatrols {};
			class initializeUAVPatrols {};			
			class initializeVehiclePatrols {};
		};
		class Functions {
			file = "addons\GMSAI\Compiles\Functions";
			class addStaticSpawn {};
			class dynamicAIManager {};
			class mainThread {};
			class monitorVehiclePatrols {};
			class monitorInfantryGroups {};			
			class monitorEmptyVehicles {};
			class monitorAirPatrols {};  
			class monitorUAVPatrols {};				
			class monitorActiveAreas {};
			class monitorInactiveAreas {};			
			class monitorDeadUnits {};
		};
	};
};
//#include "$PBOPREFIX$\addons\GMSAI\Configs\config.cpp"