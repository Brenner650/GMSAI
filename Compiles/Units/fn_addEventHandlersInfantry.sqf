params["_group"];
{
	_x addEventHandler ["Reloaded", {_this call GMSAI_fnc_EH_unitWeaponReloaded;}];
	_x addMPEventHandler ["MPKilled", {[(_this select 0), (_this select 1)] call GMSAI_fnc_EH_MPInfantryKilled;}];
	_x addMPEventHandler ["MPHit",{[_this] call GMSAI_fnc_EH_MPInfantryHit;}];
} forEach (units _group);