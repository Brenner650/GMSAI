/*
	By Ghostrider [GRG]
	Copyright 2018
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.
*/
if (!(isServer) || hasInterface) exitWith {diag_log "[GMSAI] ERROR: GMSAI SHOULD NOT BE RUN ON A CLIENT PC";};
if (!isNil "GMSAI_Initialized") exitWith {diag_log "[GMSAI] 	ERROR: GMSAI AREADY LOADED";};
call compileFinal preprocessFileLineNumbers "addons\GMSAI\init\GMSAI_init.sqf";
diag_log format["[GMSAI] Initialized at %1",diag_tickTime];
