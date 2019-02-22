diag_log format["[GMSAI] _initializeRandomSpawnLocations: GMSAI_StaticSpawnsRandom = %1",GMSAI_StaticSpawnsRandom];
if (GMSAI_StaticSpawnsRandom <= 0 || !(GMSAI_useStaticSpawns)) exitWith {};
params[["_locations",[]]];
private _blacklistedAreas = ["water"] + _locations;
for "_i" from 1 to GMSAI_StaticSpawnsRandom do
{
	private _pos = [nil,_blacklistedAreas] call BIS_fnc_randomPos;
	if !(_pos isEqualTo [0,0]) then
	{
		private _m = "";
		if (GMSAI_debug > 1) then
		{
			_m = createMarker[format["GMSAI_Random%1",_i],_pos];
			_m setMarkerShape "RECTANGLE";
			_m setMarkerSize [500,500];
			_m setMarkerText format["Random Spawn %1",_i];
			_m setMarkerColor "COLORORANGE";							
		} else {
			_m = createMarkerLocal[format["GMSAI_Random%1",_i],_pos];
			_m setMarkerShapeLocal "RECTANGLE";
			_m setMarkerSizeLocal [500,500];
		};
		[_m,GMSAI_staticRandomSettings] call GMSAI_fnc_addStaticSpawn;
		//diag_log format["_ConfigureRandomeSpanwLocations: adding spawn area #%2 at %1",_pos,_i];
		_blacklistedAreas pushBack _m;
	};
};
