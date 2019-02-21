//params["_vehicle","_role","_unit","_turret"];
params["_vehicle"];
if ({alive _x} count (crew _vehicle) == 0) then
{
	[_vehicle] call GMSAI_fnc_processEmptyVehicle;
};