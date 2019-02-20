private _leader = _this;
private _group = group _leader;
private _nearestEnemy =  _leader findNearestEnemy (position (_leader));
diag_log format["_nextWaypoint: _leader = %1 | _group = %2 | _nearestEnemy = %3",_leader,_group,_nearestEnemy];
private _blacklisted = _group getVariable "GMSAI_blackListedAreas";
if !(isNull _nearestEnemy) then
{
	diag_log format["_nextWaypointInfantry : enemies nearby condition : _groupPatrolArea = %1",_groupPatrolArea];
	//private _nextPos = [[position _nearestEnemy,100,100],1] call GMS_fnc_findRandomPosWithinArea select 0;	
	private _nextPos = position _nearestEnemy getPos[ [15,35] call GMS_fnc_getNumberFromRange,random(359)];
	diag_log format["_nextWaypoint: enemies detected, configuring SAD waypoint at _nextPos = %1",_nextPos];	
	_group setVariable["timeStamp",diag_tickTime];	
	private _wp = [_group,0];
	_wp setWaypointPosition [_nextPos,5];
	_wp setWaypointType "SAD";
	_wp setWaypointSpeed (_group getVariable "GMSAI_waypointSpeed");
	_wp setWaypointStatements ["true","this call GMSAI_fnc_nextWaypointInfantry;"];
	_wp setWaypointTimeout [45,60,75];	
	_group setCurrentWaypoint _wp;
	diag_log format["_nextWaypoint: waypoint for group %1 updated to SAD waypoint at %2",_group,_nextPos];
} else {
	private _areaMarker = _group getVariable "GMSAI_patrolArea";
	diag_log format["_nextWaypoint: _areaMarker = %1",_areaMarker];
	_areaMarkerSize = markerSize _areaMarker;
	_groupPatrolArea = [markerPos _areaMarker, [markerSize _areaMarker select 0,markerSize _areaMarker select 1,0,true]];			
	diag_log format["_nextWaypoint: _areaMarker markerSize = %1",markerSize _areaMarker];	
	diag_log format["_nextWaypoint: _groupPatrolArea = %1",_groupPatrolArea];
	private _nextPos = [_groupPatrolArea,1,[_leader],35,GMSAI_blacklistedAreas] call GMS_fnc_findRandomPosWithinArea select 0;	
	diag_log format["_nextWaypointInfantry: NO enemy neaarby | _groupPatrolArea = %1 | _nextPos = %2",_groupPatrolArea, _nextPos];	
	_group setVariable["timeStamp",diag_tickTime];
	private _wp = [_group, 0];
	_wp setWaypointPosition [_nextPos,5];
	_wp setWaypointSpeed (_group getVariable "GMSAI_waypointSpeed");
	_wp setWaypointLoiterRadius (_group getVariable "GMSAI_waypointLoiterRadius");
	_wp setWaypointType "LOITER";
	_wp setWaypointLoiterType "CIRCLE";
	_wp setWaypointStatements ["true","this call GMSAI_fnc_nextWaypoint;"];
	_wp setWaypointTimeout  [45,60,75];
	_group setCurrentWaypoint _wp;
	diag_log format["_nextWaypoint: waypoint for group updated to LOITER waypoint at %2",_group,_nextPos];
};
//  	_wp setWaypointStatements ["true","this call blck_fnc_changeToSADWaypoint;"];
/*
		Logic: If enemies known to the group are neaby, approach a random position close to the nearest enemy else move to a random location within the area to be patrolled and loiter for a period (30 secs);
*/