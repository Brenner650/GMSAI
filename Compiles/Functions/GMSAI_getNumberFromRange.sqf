params["_data"];
//diag_log format["[GMSAI] _getNumberFromRange: _this = %1",_this];
_value = objNull;
if ((typeName _data) isEqualTo "ARRAY") then
{
	if ((count _data) == 1) then
	{
		_value = _data select 0;
	} else {
		if ((count _data) == 2) then
		{
			_min = _data select 0;
			_max = _data select 1;
			if (_max > _min) then 
			{
				_value = _min + round(random(_max - _min));
			} else {
				_value = _min;
			};
		} else {
			diag_log format["[GMSAI] Error: Array %1 must have 1 or 2 scalar elements",_data];
		};
	};
};
if (typeName _data isEqualTo "SCALAR") then
{
	_value = _data;
};
//diag_log format["[GMSAI] _getNumberFromRange: value returned = %1",_value];
_value