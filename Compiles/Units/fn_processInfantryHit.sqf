private _unit = _this select 0 select 0;
private _instigator = _this select 0 select 3;
diag_log format["[GMSAI] processInfantryHit _unit = %1 | _instigator = %2",_unit,_instigator];
if (!(isPlayer _instigator)) exitWith {};
if (!(alive _unit)) exitWith {
	[_unit, _instigator] call GMSAI_fnc_processUnitKilled
};
if !(vehicle _instigator == _instigator) exitWith {_unit setDamage 0;};
(leader (group _unit)) call GMSAI_fnc_nextWaypoint;
// Possible heal functions here
[_unit,"SmokeShellPurple",_instigator getRelDir _unit] call GMS_fnc_throwSmoke;
[_unit] call GMS_fnc_healSelf;
