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
            if (_group getVariable["GMSAI_deleteAt",0] > 0) then  //  provides mechanism to handle groups left over from vehicle patrols, separate from dynamic or area-based patrols
            {
                private _nearbyPlayers = allPlayers select { (leader _group) distance _x < 300};
                if ((_nearbyPlayers isEqualTo []) && diag_tickTime > _group getVariable "GMSAI_deleteAt") then
                {
                    [_g] call GMS_fnc_despawnInfantryGroup;
                    deleteMarker _marker;                    
                } else {
                    _group setVariable["GMSAI_deleteAt",diag_tickTime + (_group getVariable["GMSAI_DespawnTime",120])];  // wait until no player is within 300 m for 120 seconds before doing deletion.
                };
            };
            GMSAI_infantryGroups pushBack _g;
        };
    };
};