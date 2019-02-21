diag_log format["[GMSAI] _initializeAircraftPatrols: Begining script | GMSAI_numberOfAircraftPatrols = %1",GMSAI_numberOfAircraftPatrols];
private _blacklistedAreas = ["water"];
for "_i" from 1 to GMSAI_numberOfAircraftPatrols do
{
	private _pos = [0,0];
	while {_pos isEqualTo [0,0]} do
	{
		_pos = [nil,_blacklistedAreas] call BIS_fnc_randomPos;
		diag_log format["[GMSAI] _initializeAircraftPatrols: _pos = %1",_pos];
	};
	if !(_pos isEqualTo [0,0]) then
	{
		private _heliPatrol = [_pos] call GMSAI_fnc_spawnHelicoptorPatrol;
		GMSAI_airPatrols pushBack [_heliPatrol select 0,_heliPatrol select 1,diag_tickTime,0,-1,-1];
	};
};
