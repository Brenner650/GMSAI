params["_areaMarker","_noPositionsToFind","_players"];
private _blackList = [];
{_blackList pushBack [getPos _x, 150]} forEach _players;
private _spawnPos = [0,0,0];
private _posnFound = [];
for "_i" from 1 to _noPositionsToFind do
{
	//diag_log format["[GMSAI] _findRandomPos Pass %1 | _areaToSearch %2 | _posnFound %3 | _players %4",_i,_areaMarker,_posnFound,_players];
	_spawnPos = [[_areaMarker],_blackList/* add condition that the spawn is not near a trader*/] call BIS_fnc_randomPos;
	//diag_log format["[GMSAI] _findRandomPos:  _spawnPos set to %1",_spawnPos];
	if (!isNil "_spawnPos" && !(_spawnPos isEqualTo [0,0])) then
	{
		_blackList pushBack [_spawnPos,[100,100,0,false]];
		_posnFound pushBack _spawnPos;
	};
};

_posnFound