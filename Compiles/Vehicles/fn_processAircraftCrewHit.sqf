params["_unit","_causedBy","_damage","_instigator"];
diag_log format["[GMSAI] processAircraftCrewHit _unit = %1 | _instigator = %2",_unit,_instigator];
if (!(isPlayer _instigator)) exitWith {};
(leader (group _unit)) call GMSAI_fnc_nextWaypoint;

