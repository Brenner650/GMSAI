params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];
_unit addMagazine _newMagazine select 0;
diag_log format["_processUnitReloaded: _unit %1  _weapon %2  _newMagazine %3",_unit,_weapon,_newMagazine select 0];