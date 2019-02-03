private _unit = _this select 0 select 0;
private _instigator = _this select 0 select 3;
if (!(isPlayer _instigator)) exitWith {};
if (!(alive _unit)) exitWith {
	[_unit, _instigator] call GMSAI_fnc_processUnitKilled
};
if !(vehicle _instigator == _instigator) exitWith {_unit setDamage 0;};
(leader (group _unit)) call GMSAI_fnc_nextWaypoint;
// Possible heal functions here