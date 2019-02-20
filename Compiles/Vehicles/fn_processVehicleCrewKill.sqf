params["_unit","_killer","_instigator"];
diag_log format["[GMSAI] crewKilled_EH: typeOf _killer = %1  |  typeOf _killer = %2",typeOf _killer, typeOf _killer];
private _vehicle = vehicle _unit;
private _group = group _unit;
_group reveal[_instigator,1];
(leader(group _unit)) call GMSAI_fnc_nextWaypointVehicles;
#define legalKill true
//private _vehicle = vehicle _killer;
[_unit,_killer,legalKill] call GMSAI_fnc_processUnitKill;
if ({alive _x} count (crew _vehicle) == 0) then
{
	[_vehicle] call GMSAI_fnc_processEmptyVehicle;
};