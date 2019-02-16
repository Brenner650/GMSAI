params["_aircraft","_causedBy","_damage","_instigator"];
diag_log format["[GMSAI] processAircraftHit _unit = %1 | _instigator = %2",_unit,_instigator];
if (!(isPlayer _instigator)) exitWith {};
(driver _aircraft) call GMSAI_fnc_nextWaypointAircraft;