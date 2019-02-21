//diag_log format["[GMSAI] _monitorInfantryGroups called at %1 with GMSAI_infantryGroups = %2",diag_tickTime,GMSAI_infantryGroups];
for "_i" from 1 to (count GMSAI_infantryGroups) do
{
    if (_i > (count GMSAI_infantryGroups)) exitWith {};
    private _g = GMSAI_infantryGroups deleteAt 0;
     if !(_g isEqualTo grpNull) then 
    {
        //  Add unstuck monitoring.
        private _m = _group getVariable "GMSAI_groupMarker";
        if !(isNil "_m") then
        {
            _m setMarkerPos getPos (leader _group);
        };
        GMSAI_infantryGroups pushBack _g;
    };
};