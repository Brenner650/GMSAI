	
    
diag_log format["[GMSAI] _fnc_spawnUAVPatrol: _this = %1",_this];
params["_pos"];
private _uav = createVehicle [selectRandomWeighted GMSAI_UAVTypes, _pos, [], 0, "FLY"];
diag_log format["[GMSAI] _fnc_spawnUAVPatrol: UAV selected = %1",_uav];
_uav setFuel 1;
_uav engineOn true;
_uav flyInHeight 100;
_uav setVehicleLock "LOCKED";
createVehicleCrew _uav;
private _group = createGroup GMS_side;
(crew _uav) joinSilent _group;
(driver _uav)  doMove (_pos getPos[3000,random(359)]); 
private _difficulty = selectRandomWeighted GMSAI_UAVDifficulty;
[_group,GMSAI_unitDifficulty select (_difficulty)] call GMS_fnc_setupGroupSkills;
[_group] call GMS_fnc_setupGroupBehavior;
[_uav] call GMS_fnc_emptyObjectInventory;
_uav addMPEventHandler["MPHit",{_this call GMSAI_fnc_EH_aircraftHit}];	
{
	_x addMPEventHandler ["MPKilled", {_this call GMSAI_fnc_EH_crewKilledHeli;}];
	_x addMPEventHandler ["MPHit", {_this call GMSAI_fnc_EH_crewHitHeli;}];
} forEach (crew _uav);
(driver _uav) call GMSAI_fnc_nextWaypointAircraft;
private _return = [_group,_uav];
_return