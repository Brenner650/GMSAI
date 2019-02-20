params["_pos"];
diag_log format["[GMSAI] _fnc_spawnVehiclePatrol: _pos = %1",_pos];
private _vehicle = createVehicle [selectRandomWeighted GMSAI_patrolVehicles, _pos, [], 10, "NONE"];
[_vehicle] call GMS_fnc_emptyObjectInventory;
private _crewCount = [GMSAI_patroVehicleCrewCount] call GMS_fnc_getIntegerFromRange;
private _group = [[0,0,0],[_crewCount] call GMS_fnc_getIntegerFromRange,0] call GMS_fnc_spawnInfantryGroup;
private _difficulty = selectRandomWeighted GMSAI_vehiclePatroDifficulty;
diag_log format["[GMSAI] _fnc_spawnVehiclePatrol: _vehicle = %1 | _crewCount = %2 | _group = %3 | _difficulty = %4",_vehicle,_crewCount,_group,_difficulty];
[_group,GMSAI_unitDifficulty select _difficulty] call GMS_fnc_setupGroupSkills;
[_group, GMSAI_unitLoadouts select _difficulty, 0 /* launchers per group */, GMSAI_useNVG, GMSAI_blacklistedGear] call GMS_fnc_setupGroupGear;
[_group,_difficulty,GMSAI_money] call GMS_fnc_setupGroupMoney;
[_group] call GMS_fnc_setupGroupBehavior;
private _crew = units _group;
_driver = _crew deleteAt 0;
_driver assignAsDriver _vehicle;
_driver moveInDriver _vehicle;
_driver call GMSAI_fnc_nextWaypointVehicles;
private _turrets = allTurrets [_vehicle,false];
{
	if !(_crew isEqualTo []) then
	{
		private _unit = _crew deleteAt 0;
		_unit assignAsTurret [_vehicle, _x];
		_unit moveInTurret [_vehicle, _x];
		diag_log format["_fnc_spawnVehiclePatrol: moving crew member %1 into turret %2 | _crew = %3",_unit,_x, _crew];
	};
} forEach _turrets;
if !(_crew isEqualTo []) then
{
	private _unit = _crew deleteAt 0;
	_unit assignAsCommander _vehicle;
	_unit moveInCommander _vehicle;
};
{
	_x assignAsCargo _vehicle;
	_x moveInCargo _vehicle;
} forEach _crew;
{deleteVehicle _x} forEach _crew;
_vehicle addMPEventHandler["MPHit",{_this call GMSAI_fnc_EH_vehicleHit}];
{
	_x addMPEventHandler ["MPKilled", {_this call GMSAI_fnc_EH_crewKilledVehicle;}];
	_x addMPEventHandler ["MPHit", {_this call GMSAI_fnc_EH_crewHitVehicle;}];
	_x addEventHandler ["GetOut",{_this call GMSAI_fnc_EH_CrewGetOut;}]
} forEach (crew _vehicle);
//  Need to add checks to to unlock vehicle if release to players is allowed.
private _return = [_group,_vehicle];
diag_log format["[GMSAI] _fnc_spawnVehiclePatrol: _return = %1",_return];
_return
