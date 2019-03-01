diag_log format["[GMSAI] _fnc_spawnMissionHeli: _this = %1",_this];
params["_pos"];
private _heli = createVehicle [selectRandomWeighted GMSAI_aircraftTypes, _pos, [], 0, "FLY"];
if (GMS_modType isEqualTo "Epoch") then {_heli call EPOCH_server_setVToken};
_heli setFuel 1;
_heli engineOn true;
_heli flyInHeight 100;
_heli setVehicleLock "LOCKED";
diag_log format["_fnc_spawnMissionHeli: heli %1 spawned at %2",_heli,getPos _heli];
private _turrets = allTurrets [_heli,false];
private _crewCount = if (count _turrets > GMSAI_aircraftGunners) then {GMSAI_aircraftGunners} else {count _turrets};
diag_log format["_fnc_spawnMissionHeli: count _turrets = %1 | _turrets = %2",count _turrets,_turrets];
private _group = [[0,0,0],_crewCount + 1,0] call GMS_fnc_spawnInfantryGroup;
private _crew = units _group;
private _pilot = _crew deleteAt 0;
_pilot assignAsDriver _heli;
_pilot moveInDriver _heli;
_pilot  doMove (_pos getPos[3000,random(359)]); 
_group selectLeader _pilot;
diag_log format["_fnc_spawnMissionHeli: group %1 contains %2 crew | _pos = %3",_group, count _crew, _pos];
//[_heli] call GMSAI_fnc_spawnParatroops;
private _difficulty = selectRandomWeighted GMSAI_aircraftPatrolDifficulty;
[_group,GMSAI_unitDifficulty select (_difficulty)] call GMS_fnc_setupGroupSkills;
[_group, GMSAI_unitLoadouts select _difficulty, 0 /* launchers per group */, GMSAI_useNVG, GMSAI_blacklistedGear] call GMS_fnc_setupGroupGear;
[_group,_difficulty,GMSAI_money] call GMS_fnc_setupGroupMoney;
[_group] call GMS_fnc_setupGroupBehavior;
//_group setSpeedMode "NORMAL";
[_heli] call GMS_fnc_emptyObjectInventory;
(_pilot) call GMSAI_fnc_nextWaypointAircraft;
//  Could build in additional check for blacklisted turrets.
private _gunnerCount = if (GMSAI_aircraftGunners > count _turrets) then {count _turrets} else {GMSAI_aircraftGunners};
{
	if !(_crew isEqualTo []) then
	{
		private _unit = _crew deleteAt 0;
		_unit assignAsTurret [_heli, _x];
		_unit moveInTurret [_heli, _x];
		diag_log format["_fnc_spawnMissionHeli: moving crew member %1 into turret %2 | _crew = %3",_unit,_x, _crew];
	};
} forEach _turrets;
{deleteVehicle _x} forEach _crew;
_heli addMPEventHandler["MPHit",{_this call GMSAI_fnc_EH_aircraftHit}];
{
	_x addMPEventHandler ["MPKilled", {_this call GMSAI_fnc_EH_crewKilledHeli;}];
	_x addMPEventHandler ["MPHit", {_this call GMSAI_fnc_EH_crewHitHeli;}];
	_x addEventHandler ["GetOut",{_this call GMSAI_fnc_EH_CrewGetOut;}]	
} forEach (crew _heli);
//  Need to add checks to to unlock vehicle if release to players is allowed.
private _return = [_group,_heli];
diag_log format["[GMSAI] _fnc_spawnMissionHeli: _return = %1",_return];
_return
