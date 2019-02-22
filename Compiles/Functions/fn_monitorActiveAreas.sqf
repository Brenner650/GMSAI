#define respawnAt 4
#define areaDescriptor 0
#define areaGroups 3
#define timesSpawned 5
#define GMSAI_staticDespawnDistance 300
//diag_log format["[GMSAI] running ACTIVE area monitor at %1 with %2 ACTIVE areas",diag_tickTime,count GMSAI_activeStaticSpawns];
for "_i" from 1 to (count GMSAI_activeStaticSpawns) do
{
	if (_i > (count GMSAI_activeStaticSpawns)) exitWith  {};
	private _areaParameters = GMSAI_activeStaticSpawns deleteAt 0;
	//  GMSAI_StaticSpawns pushBack [_areaDescriptor, _staticAiDescriptor, GMSAI_infantry, [grpNull],respawnAt, timesSpawned];
	//diag_log format["[GMSAI] _monitorActiveAreas: _areaParameters = %1",_areaParameters];
	if !(isNil "_areaParameters") then
	{
		_areaParameters params["_area","_playerPresentTimeStamp"];
		private _players = allPlayers inAreaArray (_area select 0);	
		//private _aliveGroups = {!(isNull _x)} count (area select areaGroups);
		private _aliveGroups = [];
		{
			private _group = _x;
			if (!(_group isEqualTo grpNull) && ({alive _x} count (units _group)) > 0) then {_aliveGroups pushBack _group};
		} forEach (_area select areaGroups);
		//diag_log format["[GMSAI] _monitorActiveAreas: _aliveGroups = %1 | _areaGroups = %2",_aliveGroups,_area select areaGroups];
		//diag_log format["GMSAI] _monitorActiveAreas: _players = %1 | _aliveGroups = %2",_players,_aliveGroups];
		if ((_players isEqualTo [])) then
		{
			//diag_log format["[GMSAI] area %1 empty at %2 with _playerPresentTimeStamp = %3",_area,diag_tickTime,_playerPresentTimeStamp];
			if (diag_tickTime > (GMSAI_staticDespawnTime + _playerPresentTimeStamp)) then
			{
				//diag_log format["[GMSAI] static area % deactivated at %2",_area,diag_tickTime];
				// Do something here to clean up any remaining groups and include a timestamp check.
				{
					[_x] call GMS_fnc_despawnInfantryGroup;
				}forEach _aliveGroups;
				private _oldArea = +_area;
				_area set[4,diag_tickTime];
				//diag_log format["[GMSAI] _area updated from %1 to %2",_oldArea,_area];
				GMSAI_StaticSpawns pushBack _area;
			} else {
				GMSAI_activeStaticSpawns pushBack [_area,_playerPresentTimeStamp];
			};
		} else {
			if (_aliveGroups isEqualTo []) then
			{
				diag_log format["[GMSAI] all groups in static area killed at %1",diag_tickTime];
				_area set[4,diag_tickTime];
				GMSAI_StaticSpawns pushBack _area;				
			} else {
				GMSAI_activeStaticSpawns pushBack [_area,diag_tickTime];
			};
		};
	};
};
