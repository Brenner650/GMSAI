params["_unit","_causedBy","_damage","_instigator"];
diag_log format["[GMSAI] processInfantryHit _unit = %1 | _instigator = %2",_unit,_instigator];
if (!(isPlayer _instigator)) exitWith {};
if (alive _unit) then {
	if ((currentWeapon _instigator) in GMSAI_forbidenWeapons) then {
		_unit setDamage ((damage _unit) - _damage);
	} else {
		// Possible heal functions here
		if !(_unit getVariable["GMSAI_hasHealed",false]) then
		{
			[_unit,"SmokeShellPurple",_instigator getRelDir _unit] call GMS_fnc_throwSmoke;
			[_unit] call GMS_fnc_healSelf;
			_unit setVariable["GMSAI_hasHealed",true];
		};
	};
	(leader (group _unit)) call GMSAI_fnc_nextWaypoint;	
};
