private _leader = _this;
private _group = group _leader;
private _nearestEnemy =  _leader findNearestEnemy (position (_leader));
diag_log format["_nextWaypointAircraft: _leader = %1 | _group = %2 | _nearestEnemy = %3",_leader,_group,_nearestEnemy];
if !(isNull _nearestEnemy) then
{
	private _nextPos = position _nearestEnemy getPos[ [3,30/(_leader knowsAbout _nearestEnemy)] call GMS_fnc_getNumberFromRange,random(359)];
	diag_log format["_nextWaypointAircraft: enemies detected, configuring SAD waypoint at _nextPos = %1",_nextPos];	
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
	private _nextPos = [0,0];
	while {_nextPos isEqualTo [0,0]} do
	{
		_nextPos = [nil,GMSAI_blacklistedAreas + ["water",[position _leader,500]]] call BIS_fnc_randomPos; // find a new location outside a radius of 500 m from the position of the aircraft.
	};
	if (_nextPos distance (position _leader) > 5000) then
	{
		_nextPos = _nextPos getPos[2000 + random(3000),_leader getRelDir _nextPos];
	};
	diag_log format["_nextWaypointAircraft: _nextPos = %1",_nextPos];
	_group setVariable["timeStamp",diag_tickTime];
	private _wp = [_group, 0];
	_wp setWaypointPosition [_nextPos,5];
	_wp setWaypointSpeed "LIMITED";
	_wp setWaypointLoiterRadius 150;
	_wp setWaypointType "LOITER";
	_wp setWaypointLoiterType "CIRCLE_L";
	_wp setWaypointStatements ["true","this call GMSAI_fnc_nextWaypointAircraft;"];
	_wp setWaypointTimeout  [15,20,25];
	_group setCurrentWaypoint _wp;
	diag_log format["_nextWaypointAircraft: waypoint for group updated to LOITER waypoint at %2",_group,_nextPos];
};