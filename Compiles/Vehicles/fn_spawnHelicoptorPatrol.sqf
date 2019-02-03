//diag_log format["[GMSAI] _fnc_spawnMissionHeli: _this = %1",_this];
params["_pos"];
private _group = [[0,0,0],GMSAI_gunners + 1,0] call GMS_fnc_spawnInfantryGroup;
private _difficulty = selectRandomWeighted GMSAI_aircraftPatrolDifficulty;
[_group,GMSAI_unitDifficulty select (_difficulty)] call GMS_fnc_setupGroupSkills;
[_group, GMSAI_unitLoadouts select _difficulty, 0 /* launchers per group */, GMSAI_useNVG, GMSAI_blacklistedGear] call GMS_fnc_setupGroupGear;
[_group,_difficulty,GMSAI_money] call GMS_fnc_setupGroupMoney;
[_group] call GMS_fnc_setupGroupBehavior;
_group setSpeedMode "NORMAL";
(leader _group) call GMSAI_fnc_nextWaypointAircraft;
private _patrolHeli = createVehicle [selectRandomWeighted GMSAI_aircraftTypes, _pos, [], 90, "FLY"];
_patrolHeli setVehicleLock "LOCKED";
[_patrolHeli] call GMS_fnc_emptyObjectInventory;
private _crew = units _group;
private _driver = _crew deleteAt 0;
_driver assignAsDriver _patrolHeli;
_driver moveInDriver _patrolHeli;
_group selectLeader _driver;
private _turrets = allTurrets [_patrolHeli,false];
//  Could build in additional check for blacklisted turrets.
private _gunnerCount = if (GMSAI_gunners > count _turrets) then {count _turrets} else {GMSAI_gunners};
for "_i" from 1 to _gunnerCount do
{
	private _unit = _crew deleteAt 0;
	_unit assignAsTurret [_patrolHeli, _x];
	_unit moveInTurret [_patrolHeli, _x];
};
//  Need to add checks to to unlock vehicle if release to players is allowed.
private _return = [_group,_patrolHeli];
//diag_log format["[GMSAI] _fnc_spawnMissionHeli: _return = %1",_return];
_return
