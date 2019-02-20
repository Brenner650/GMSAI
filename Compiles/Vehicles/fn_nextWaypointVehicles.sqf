private _driver = _this;
private _group = group _driver;
private _veh = vehicle _driver;
//deleteMarker "doMoveMarker";
//systemChat format["_veh initialized = %1",_veh getVariable["initialized",false]];
if !(_veh getVariable["initialized",false]) exitWith
{
	//systemChat "moving vehicle to nearest road";
	private _road = [getPosATL _veh,1000] call BIS_fnc_nearestRoad;
	//_m = createMarker["doMoveMarker",getPos _road];			
	//_m setMarkerType "mil_dot";
	//_m setMarkerColor "ColorGreen";
	private _wp = _group addWaypoint [_group,0,0,"movetoRoad"];
	_wp setWaypointPosition[getPosATL _road,0];
	_wp setWaypointStatements ["true","this call fn_nextWaypointVehicle;"];
	_group setCurrentWaypoint [_group,0]; 
	_veh setVariable["initialized",true];

};
private _nearestEnemy =  _leader findNearestEnemy (position (_leader));
diag_log format["_nextWaypointVehicle: _leader = %1 | _group = %2 | _nearestEnemy = %3",_leader,_group,_nearestEnemy];
//private _blacklisted = _group getVariable "GMSAI_blacklistedAreas";
if !(isNull _nearestEnemy) then
{
	private _nextPos = position _nearestEnemy getPos[ [15,35] call GMS_fnc_getNumberFromRange,random(359)];
	diag_log format["_nextWaypointVehicle: enemies detected, configuring SAD waypoint at _nextPos = %1",_nextPos];	
	_group setVariable["timeStamp",diag_tickTime];	
	private _wp = [_group,0];
	_wp setWaypointPosition [_nextPos,5];
	_wp setWaypointType "SAD";
	_wp setWaypointSpeed "LIMITED";
	_wp setWaypointStatements ["true","this call GMSAI_fnc_nextWaypointVehicle;"];
	_wp setWaypointTimeout [45,60,75];	
	_group setCurrentWaypoint _wp;
	diag_log format["GMSAI_fnc_nextWaypointVehicle: waypoint for group %1 updated to SAD waypoint at %2",_group,_nextPos];
} else {
	//systemChat "moving vehicle to nearby location";
	private _nearLocations = nearestLocations [position _driver, ["NameCity","NameCityCapital","NameMarine","NameVillage","NameLocal","Airport"],2000];
	//systemchat format["near locations = %1",_nearLocations];
	private _pos = position _veh;
	private _loc = "";
	while {_veh distance _pos < 500} do
	{
		_loc = selectRandom _nearLocations;
		_pos = locationPosition _loc;
	};
	//systemChat format["position selected = %1 located at %2",text _loc,locationPosition _loc];
	//_m = createMarker["wpPos",_pos];
	//_m setMarkerType "mil_dot";	
	//_m setMarkerPos _pos;
	//_m setMarkerText text _loc;
	//_m setMarkerColor "ColorRed";
	private _wp = _group addWaypoint [_pos,0,0,format["%1",text _loc]];
	_wp setWaypointPosition[_pos,10];
	_wp setWaypointTimeout[5,7,9];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointStatements ["true","this call GMSAI_fnc_nextWaypointVehicles;"];	
	_group setCurrentWaypoint [_group,0]; 	
};	
