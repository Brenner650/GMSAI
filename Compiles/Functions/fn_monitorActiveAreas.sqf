//diag_log format["[GMSAI] running ACTIVE area monitor at %1 with %2 ACTIVE areas",diag_tickTime,count GMSAI_activeStaticSpawns];
// GMSAI_StaticSpawns pushBack [_areaDescriptor, _staticAiDescriptor, GMSAI_infantry, [grpNull],lastSpawned, timesSpawned];
for "_i" from 1 to (count GMSAI_activeStaticSpawns) do
{
	if (_i > (count GMSAI_activeStaticSpawns)) exitWith  {};
	private _areaParameters = GMSAI_activeStaticSpawns deleteAt 0;
	if !(isNil "_areaParameters") then
	{
		_areaParameters params["_area","_playerPresentTimeStamp"];
		private _players = allPlayers inAreaArray (_area select 0);	
		if ((_players isEqualTo [])) then
		{
			//diag_log format["[GMSAI] area %1 empty at %2 with _playerPresentTimeStamp = %3",_area,diag_tickTime,_playerPresentTimeStamp];
			if (diag_tickTime > (GMSAI_staticDespawnTime + _playerPresentTimeStamp)) then
			{
				//diag_log format["[GMSAI] static area % deactivated at %2",_area,diag_tickTime];
				// Do something here to clean up any remaining groups and include a timestamp check.
				private _oldArea = _area;
				_area set[4,diag_tickTime];
				//diag_log format["[GMSAI] _area updated from %1 to %2",_oldArea,_area];
				GMSAI_StaticSpawns pushBack _area;
			} else {
				GMSAI_activeStaticSpawns pushBack [_area,_playerPresentTimeStamp];
			};
		} else {
			GMSAI_activeStaticSpawns pushBack [_area,diag_tickTime];
		};
	};
};
