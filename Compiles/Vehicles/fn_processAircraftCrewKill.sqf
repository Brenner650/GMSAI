params["_unit","_killer","_instigator"];
diag_log format["[GMSAI] crewKilled_EH: typeOf _killer = %1  |  typeOf _killer = %2",typeOf _killer, typeOf _killer];
private _vehicle = vehicle _unit;
_instigator reveal[_instigator,1];
_unit call GMSAI_fnc_nextWaypointAircraft;
_this call GMSAI_fnc_processVehicleCrewKill;




