fn_selectDropWaypoint = {
	diag_log format ["heli %1 slowing for paratroop deployment",vehicle _this];
	private _group = group _this;
	_group setCurrentWaypoint [_group, 2];
};
fn_arrivedOnStation = {
	_group = group(_this);
	_heli = vehicle (_this);
	_heli setSpeedMode "LIMITED";
	_this call fn_dropPayload;
	diag_log format["Heli %1 Arrived On Station",_heli];	
};
fn_dropPayload = {
	_heli = vehicle _this;
	if !(_heli getVariable["PayloadDelivered",false]) then
	{
		diag_log "=================";
		diag_log format["payload delivered by heli", _heli];
		_heli setVariable["PayloadDelivered",true];
		[_heli] call GMSAI_fnc_spawnParatroops;
	};
};
fn_hoverAndDropoff = {
	_group = group _this;
	_heli = vehicle (_this);
	_heli call fn_dropPayload;	
	_group setCurrentWaypoint[_group,4];
};
fn_cleanup = {
	_heli = vehicle _this;
	diag_log format ["transport %1 cleanup handled",_heli];
	deleteVehicle _heli;
};
fn_selectDropWaypoint = {
	_group = group _this;
	diag_log "selecting Drop waypoint";
	_group setCurrentWaypoint[_group,2];
};

private _unit = _this;  // The unit to which the paras will hone in.
private _heliType = selectRandomWeighted GMSAI_paratroopAircraftTypes;
diag_log format["fn_flyInParatroops -> Start at: %1",diag_tickTime];
private _spawnPos = (position _unit) getPos[3000,random(359)];
// _distanceToDropZone = _spawnPos distance _unit;
//_distanceToFirstWP = (_spawnPos distance _unit) - 500;
private _heli = createVehicle[selectRandomWeighted GMSAI_paratroopAircraftTypes,_spawnPos,[],0,"FLY"];
diag_log format["fn_flyInParatroops: heli %1 spawned",_heli];
//private _dir = _heli getRelDir (position _unit);
_heli setFuel 1;
_heli engineOn true;
_heli flyInHeight 100;
createVehicleCrew _heli;
_group = group(driver _heli);
diag_log format["fn_flyInParatroops: group %1 used as crew for heli %2",_group,_heli];
//_deliverPayloadLocation = position _unit;
//_wp1Distance = (_heli distance _unit) - 500;
_wp1 = _group addWaypoint [position _heli getPos[(_heli distance _unit) - 500, _heli getRelDir (position _unit)],1,1,"targetappoach"];
_wp1 setWaypointPosition [position _heli getPos[(_heli distance _unit) - 500, _heli getRelDir (position _unit)],0];
_wp1 setWaypointStatements["true","this call fn_selectDropWaypoint;"];
_wp2 = _group addWaypoint [position _unit, 100,2, "targetPosition"];
_wp2 setWaypointSpeed "LIMITED";
_wp2 setWaypointStatements ["true","this call fn_arrivedOnStation;"];
_wp4 = _group addWaypoint[(position _unit) getPos[3000,(_unit getRelDir _spawnPos) + 180],0,3,"despanPosn"];
_wp4 setWaypointStatements["true","this call fn_cleanup;"];
_wp4 setWaypointSpeed "NORMAL";