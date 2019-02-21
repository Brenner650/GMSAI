diag_log format["[GMSAI] _initializeUAVPatrols: GMSAI_numberOfUAVPatrols = %1",GMSAI_numberOfUAVPatrols];
private _blacklistedAreas = ["water"];
for "_i" from 1 to GMSAI_numberOfUAVPatrols do
{
	private _pos = [0,0];
	while {_pos isEqualTo [0,0]} do
	{
		_pos = [nil,_blacklistedAreas] call BIS_fnc_randomPos;
		diag_log format["[GMSAI] _initializeUAVPatrols: _pos = %1",_pos];
	};
	if !(_pos isEqualTo [0,0]) then
	{
		private _uavPatrol = [_pos] call GMSAI_fnc_spawnUAVPatrol;
		_driver = driver (_uavPatrol select 1);
		_driver call GMSAI_fnc_flyInParatroops;
		GMSAI_UAVPatrols pushBack [_uavPatrol select 0,_uavPatrol select 1,diag_tickTime,0,-1,-1];
	};
};
