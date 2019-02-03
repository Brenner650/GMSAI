//diag_log format["[GMSAI] _initializeAircraftPatrols: Begining script | GMSAI_numberOfAircraftPatrols = %1",GMSAI_numberOfAircraftPatrols];
private _blacklistedAreas = ["water"];
private _locations = [];
private _locMarkers = [];
for "_i" from 1 to GMSAI_numberOfAircraftPatrols do
{
	private _pos = [nil,_blacklistedAreas] call BIS_fnc_randomPos;
	//diag_log format["[GMSAI] _initializeAircraftPatrols: _pos = %1",_pos];
	if !(_pos isEqualTo [0,0]) then
	{
		_locations pushBack _pos;
		private _m = createMarker[format["GMSAIairPatrol%1",_i],_pos];
		_m setMarkerShape "RECTANGLE";
		_m setMarkerSize [2000,2000];
		_blacklistedAreas pushBack _m;
		_locMarkers pushBack _m;
	};
};
{deleteMarker _x} forEach _locMarkers;
{
	private _heliPatrol = [_x] call GMSAI_fnc_spawnHelicoptorPatrol;
	//diag_log format["[GMSAI] _initializeAircraftPatrols: _heliPatrol = %1",_heliPatrol];
	// current group, current vehicle, last spawned, times spawned, last paratroop drop.
	GMSAI_airPatrols pushBack [_heliPatrol select 0,_heliPatrol select 1,diag_tickTime,0,-1,-1];
} forEach _locations;