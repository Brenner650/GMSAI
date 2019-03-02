//diag_log format["[GMSAI] _monitorInfantryGroups called at %1 with GMSAI_infantryGroups = %2",diag_tickTime,GMSAI_infantryGroups];
// Used to monitor dynamic AI groups 'detached' from a player such as by travel in a vehicle, or remanants from a vehicle patrol.
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
            if (_group getVariable["GMSAI_deleteAt",0] == 0) then  
            {
                _group setVariable["GMSAI_deleteAt",diag_tickTime + (_group getVariable["GMSAI_DespawnTime",120])];
            };
            if (diag_tickTime > _group getVariable "GMSAI_deleteAt") then
            {
                //diag_log format["_monitorInfantryGroups: time-dependent delete criteria met for group %1: test for nearby players",_group];
                //private _nearbyPlayers = allPlayers select {(leader _group) distance _x < _group getVariable["GMSAI_despawnDistance",300]};
                private _nearbyPlayers = allPlayers inAreaArray [getPos (leader _group),_group getVariable["GMSAI_despawnDistance",300],_group getVariable["GMSAI_despawnDistance",300]];
                if (_nearbyPlayers isEqualTo [])  then
                {
                   // diag_log format["_monitorInfantryGroups: no players near, deleting group %1",_group];
                    [_group] call GMS_fnc_despawnInfantryGroup;
                    deleteMarker _marker;                    
                } else {
                    //diag_log format["_monitorInfantryGroups: players nearby, defer deletion of group %1",_group];
                    _group setVariable["GMSAI_deleteAt",diag_tickTime + (_group getVariable["GMSAI_DespawnTime",120])];
                };
            };
            GMSAI_infantryGroups pushBack _g;
        };
    };
};