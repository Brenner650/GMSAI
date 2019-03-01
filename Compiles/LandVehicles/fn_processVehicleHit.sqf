params["_vehicle","_causedBy","_damage","_instigator"];
//diag_log format["[GMSAI] processVehicleHit _unit = %1 | _instigator = %2",_unit,_instigator];
if (!(isPlayer _instigator)) exitWith 
{
	_vehicle setDamage ((damage _vehicle) - _damage);
	//diag_log format["_processVehicleHit: random damage by %3 detected, damage for vehicle %1 reset to %2",_vehicle,damage _vehicle,_instigator];
}; // AI seem to drive into things and shoot up their own vehicle thereby damaging the vehicle so fix any damage in this case.
if ((currentWeapon _instigator) in GMSAI_forbidenWeapons) exitWith
{
	_vehicle setDamage ((damage _vehicle) - _damage);
};
(driver _vehicle) reveal[_instigator,0.1];
(driver _vehicle) call GMSAI_fnc_nextWaypointVehicle;