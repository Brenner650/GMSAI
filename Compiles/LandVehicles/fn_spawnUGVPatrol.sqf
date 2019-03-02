params["_pos"];
diag_log format["[GMSAI] _fnc_spawnUGVPatrol: _pos = %1",_pos];
private _vehicle = createVehicle [selectRandomWeighted GMSAI_patrolVehicles, _pos, [], 10, "NONE"];
createVehicleCrew _vehicle;
//if (GMS_modType isEqualTo "Epoch") then {_vehicle call EPOCH_server_setVToken};
[_vehicle] call GMS_fnc_emptyObjectInventory;
private _crewCount = [GMSAI_patroVehicleCrewCount] call GMS_fnc_getIntegerFromRange;
private _group = createGroup GMS_side;
(crew _vehicle) joinSilent _group;
private _group = [[0,0,0],[_crewCount] call GMS_fnc_getIntegerFromRange,0] call GMS_fnc_spawnInfantryGroup;
private _difficulty = selectRandomWeighted GMSAI_vehiclePatroDifficulty;
//diag_log format["[GMSAI] _fnc_spawnUGVPatrol: _vehicle = %1 | _crewCount = %2 | _group = %3 | units _group %4 | _difficulty = %5",_vehicle,_crewCount,_group,units _group,_difficulty];
[_group,GMSAI_unitDifficulty select _difficulty] call GMS_fnc_setupGroupSkills;
//[_group, GMSAI_unitLoadouts select _difficulty, 0 /* launchers per group */, GMSAI_useNVG, GMSAI_blacklistedGear] call GMS_fnc_setupGroupGear;
//[_group,_difficulty,GMSAI_money] call GMS_fnc_setupGroupMoney;
[_group] call GMS_fnc_setupGroupBehavior;
//private _crew = units _group;
//[_vehicle,units _group] call GMS_fnc_loadVehicleCrew;
_vehicle addMPEventHandler["MPHit",{_this call GMSAI_fnc_EH_vehicleHit}];
{
	_x addMPEventHandler ["MPKilled", {_this call GMSAI_fnc_EH_crewKilledVehicle;}];
	_x addMPEventHandler ["MPHit", {_this call GMSAI_fnc_EH_crewHitVehicle;}];
	//_x addEventHandler ["GetOut",{_this call GMSAI_fnc_EH_CrewGetOut;}]
} forEach (crew _vehicle);
diag_log format["_fnc_spawnUGVPatrol: driver = %1",driver _vehicle];
(driver _vehicle) call GMSAI_fnc_nextWaypointVehicles;
//  Need to add checks to to unlock vehicle if release to players is allowed.
private _return = [_group,_vehicle];
diag_log format["[GMSAI] _fnc_spawnUGVPatrol: _return = %1",_return];
_return
