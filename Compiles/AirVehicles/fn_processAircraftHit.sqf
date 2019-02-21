params["_aircraft","_causedBy","_damage","_instigator"];
diag_log format["[GMSAI] processAircraftHit _unit = %1 | _instigator = %2",_unit,_instigator];
if (!(isPlayer _instigator)) exitWith {};
if ((currentWeapon _instigator) in GMSAI_forbidenWeapons) exitWith
{
	_aircraft setDamage ((damage _aircraft) - _damage);
};
group(driver _aircraft) reveal[_instigator,0.1];
group(driver _aircraft) call GMSAI_fnc_nextWaypointAircraft;