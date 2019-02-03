params["_classnameInfo"];  //  Assumes an array of arrays, where for each subarray, the first element is an array of classnames to be checked.
for "_i" from 1 to (count _classnameInfo) do
{
    private _cni = _classnameInfo deleteAt 0;
	diag_log format["[GMSAI] fn_checkClassnames: _cnl = %1",_cnl];
    private _cn = [_cnl select 0 select 0] call GMSAI_fnc_checkClassnames;
	_cnl set[0,_cn];
    _classnameInfo pushBack _cnl;
};
_classnameInfo