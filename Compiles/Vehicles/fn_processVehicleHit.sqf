params["_vehicle","_causedBy","_damage","_instigator"];
diag_log format["[GMSAI] processVehicleHit _unit = %1 | _instigator = %2",_unit,_instigator];
if (!(isPlayer _instigator)) exitWith {};
if ((currentWeapon _instigator) in GMSAI_forbidenWeapons) exitWith
{
	_vehicle setDamage ((damage _vehicle) - _damage);
};
(driver _vehicle) reveal[_instigator,0.1];
(driver _vehicle) call GMSAI_fnc_nextWaypointVehicle;