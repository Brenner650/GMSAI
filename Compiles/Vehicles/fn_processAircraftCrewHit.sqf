params["_unit","_causedBy","_damage","_instigator"];
diag_log format["[GMSAI] processAircraftCrewHit _unit = %1 | _instigator = %2",_unit,_instigator];
if (!(isPlayer _instigator)) exitWith {};
private _vehicle = vehicle _unit;
private _group = group _unit;
_group reveal[_instigator,1];
(leader (group _unit)) call GMSAI_fnc_nextWaypoint;

