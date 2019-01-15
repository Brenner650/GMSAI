/*
	By Ghostrider [GRG]
	Copyright 2016
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/

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
		class Units {
			file = "addons\GMSAI\Compiles\Units";
			class infantryGroupMonitor {};
			class nextWaypoint {};
			class initializeWaypoint {};
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
		};
	};
};
