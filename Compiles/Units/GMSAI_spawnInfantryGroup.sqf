params["_groupPos","_units","_alertDistance"];
diag_log format["[GMSAI] _spawnInfantryGroup: _this = %1",_this];
diag_log format["{GMSAI] _spawnInfantryGroup: _groupPos %1 | _units = %2 | _alertDistance %3",_groupPos,_units,_alertDistance];
private _group = createGroup GMSAI_side;
_players = _groupPos nearEntities["Man",300] select {isPlayer _x};
{_group reveal[_x,1]} forEach _players;
for "_i" from 1 to _units do
{
	_u = _group createUnit [GMSAI_unitType,_groupPos,[],10,"NONE"];
};
//diag_log format["_spawnInfantryGroup: _group = %1",_group];
_group

