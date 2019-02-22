//diag_log format["[GMSAI] _monitorInfantryGroups called at %1 with GMSAI_infantryGroups = %2",diag_tickTime,GMSAI_infantryGroups];
for "_i" from 1 to (count GMSAI_infantryGroups) do
{
    if (_i > (count GMSAI_infantryGroups)) exitWith {};
    private _g = GMSAI_infantryGroups deleteAt 0;
    private _group = grpNull;
    private _marker = "";
    //diag_log format["[GMSAI] _monitorInfantryGroups: _g = %1",_g];
    if (typeName _g isEqualTo "ARRAY") then
    {
        _group = _g  select 0;
        _marker = _g select 1;
    };
    if (typeName _g isEqualTo "GROUP") then
    {
        _group = _g;
        _marker = _group getVariable "GMSAI_groupMarker";
    };
    if (_group isEqualTo grpNull) then
    {
         deleteMarker _marker;
    } else {
        if ({alive _x} count (units _group) == 0) then
        {
            deleteGroup _group;
            deleteMarker _marker;
        } else {
            if !(isNil "_marker") then
            {
                _marker setMarkerPos getPos (leader _group);
            };
            GMSAI_infantryGroups pushBack _g;
        };
    };
};