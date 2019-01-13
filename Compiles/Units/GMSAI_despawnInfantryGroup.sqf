params["_group"];
if (isNull _group) exitWith {};
diag_log format["_deleteInfantryGroup: _group = %1",_group];
{deleteVehicle _x} forEach units _group;
deleteGroup _group;