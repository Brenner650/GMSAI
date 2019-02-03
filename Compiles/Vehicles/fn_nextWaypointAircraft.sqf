private _leader = _this;
private _group = group _leader;
private _nearestEnemy =  _leader findNearestEnemy (position (_leader));
//diag_log format["_nextWaypointAircraft: _leader = %1 | _group = %2 | _nearestEnemy = %3",_leader,_group,_nearestEnemy];
private _blacklisted = _group getVariable "GMSAI_blacklistedAreas";
if !(isNull _nearestEnemy) then
{
	//diag_log format["_nextWaypoint : enemies nearby condition : _groupPatrolArea = %1",_groupPatrolArea];
	//private _nextPos = [[position _nearestEnemy,100,100],1] call GMS_fnc_findRandomPosWithinArea select 0;	
	private _nextPos = position _nearestEnemy getPos[ [15,35] call GMS_fnc_getNumberFromRange,random(359)];
	//diag_log format["_nextWaypointAircraft: enemies detected, configuring SAD waypoint at _nextPos = %1",_nextPos];	
	_group setVariable["timeStamp",diag_tickTime];	
	private _wp = [_group,0];
	_wp setWaypointPosition [_nextPos,5];
	_wp setWaypointType "SAD";
	_wp setWaypointSpeed "LIMITED";
	_wp setWaypointStatements ["true","this call GMSAI_fnc_nextWaypointAircraft;"];
	_wp setWaypointTimeout [45,60,75];	
	_group setCurrentWaypoint _wp;
	diag_log format["_nextWaypointAircraft: waypoint for group %1 updated to SAD waypoint at %2",_group,_nextPos];
} else {
	private _nextPos = [nil,GMSAI_blacklistedAreas] call BIS_fnc_randomPos;	
	_group setVariable["timeStamp",diag_tickTime];
	private _wp = [_group, 0];
	_wp setWaypointPosition [_nextPos,5];
	_wp setWaypointSpeed "LIMITED";
	_wp setWaypointLoiterRadius 150;
	_wp setWaypointType "LOITER";
	_wp setWaypointLoiterType "CIRCLE_L";
	_wp setWaypointStatements ["true","this call GMSAI_fnc_nextWaypointAircraft;"];
	_wp setWaypointTimeout  [45,60,75];
	_group setCurrentWaypoint _wp;
	diag_log format["_nextWaypointAircraft: waypoint for group updated to LOITER waypoint at %2",_group,_nextPos];
};