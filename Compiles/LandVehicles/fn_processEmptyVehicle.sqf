params["_vehicle"];
//diag_log format["_processEmptyVehicle: _vehicle = %1",_vehicle];
if (GMSAI_releaseVehiclesToPlayers == 1) then
{
	_vehicle setVariable["GMSAI_deleteAt",diag_tickTime + GMSAI_vehicleDeleteTimer];
	[_vehicle,0] remoteExecCall ["lock",_vehicle];
	[_vehicle,["GetIn","GetOut","Reloaded","HitPart"]] call GMS_fnc_removeEventHandlers;
	[_vehicle,["MPHit","MPKilled"]] call GMS_fnc_removeMPEventHandlers;
} else {
	_vehicle setVariable["GMSAI_deleteAt",diag_tickTime + 60];
};
GMSAI_emptyVehicles pushBack _vehicle;
//diag_log format["_processEmptyVehicle: GMSAI_emptyVehicles updated to %1",GMSAI_emptyVehicles];
