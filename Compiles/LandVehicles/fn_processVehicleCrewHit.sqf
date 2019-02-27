params["_unit","_causedBy","_damage","_instigator"];
diag_log format["[GMSAI] processVehicletCrewHit _unit = %1 | _instigator = %2",_unit,_instigator];
if (!(isPlayer _instigator)) exitWith 
{
	_unit setDamage ((damage _unit) - _damage);
	diag_log format["_processVehicleCrewHit: crew %1 damaged by %2 so damage reset to %3",_unit,_instigator,damage _unit];
};  // AI seem to drive into things thereby damaging the units transported by the vehicle so fix any damage in this case.
private _vehicle = vehicle _unit;
private _group = group _unit;
_group reveal[_instigator,0.1];
if ((currentWeapon _instigator) in GMSAI_forbidenWeapons) then 
{
	_unit setDamage ((damage _unit) - _damage);
};
(leader (group _unit)) call GMSAI_fnc_nextWaypointVehicles;