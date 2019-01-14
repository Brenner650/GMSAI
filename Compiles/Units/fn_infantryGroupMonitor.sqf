//diag_log format["[GMSAI] group monitor called with GMSAI_infantryGroups = %1",GMSAI_infantryGroups];
for "_i" from 0 to (count GMSAI_infantryGroups) do
{
	private _element = GMSAI_infantryGroups deleteAt 0;
	if !(isNil "_element") then
	{
		//diag_log format["[GMSAI] _infantryGroupMonitor: evaluating element %1",_element];
		_element params["_group","_groupMarker","_player","_respawnTime"];
		//diag_log format["[GMSAI] _infantryGroupMonitor: params of element: _group %1 | _groupMarker",_group,_groupMarker];
		if ( (isNull _group)) then
		{
			deleteMarker _groupMarker;
			if !(_player isEqualTo "") then
			{
				_player setVariable["GMSAI_dynamicRespawnAt",_respawnTime + diag_tickTime];
				_player setVariable["GMSAI_playerGroup",nil];
			};			
		}  else {
			if (({alive _x} count units _group) == 0) then
			{
				deleteGroup _group;
				deleteMarker _groupMarker;
				if !(_player isEqualTo "") then
				{
					_player setVariable["GMSAI_dynamicRespawnAt",_respawnTime + diag_tickTime];
					_player setVariable["GMSAI_playerGroup",nil];
				};				
			} else {
				private _leader = leader _group;
				private _despawnDist = _group getVariable "GMSAI_despawnDistance";
				private _lastEvaluated = _group getVariable "GMSAI_lastEvaluated";		
				if (isNil "_lastEvaluated") then
				{
					_lastEvaluated = diag_tickTime;
					_group setVariable["GMSAI_lastEvaluated",_lastEvaluated];
				};
				private _players = allPlayers inAreaArray [position _leader,_despawnDist,_despawnDist];
				if (_players isEqualTo []) then
				{
					private _despawnTime = _group getVariable "GMSAI_DespawnTime";		
					if (diag_tickTime > (_lastEvaluated + _despawnTime)) then
					{
						//diag_log format["[GMSAI] _infantryGroupMonitor: deleting group %1 at time %2",_group,diag_tickTime];
						deleteMarker _groupMarker;
						[_group] call GMS_fnc_despawnInfantryGroup;
						if !(_player isEqualTo "") then
						{
							_player setVariable["GMSAI_dynamicRespawnAt",_respawnTime + diag_tickTime];
							_player setVariable["GMSAI_playerGroup",nil];
						};
					} else {
						GMSAI_infantryGroups pushBack _element;
						if (GMSAI_debug > 1) then
						{
							_groupMarker setMarkerPos (position _leader);
							_groupMarker setMarkerText format["%1 / %2 units",_group,count units _group];
						};
					};
				} else {
					_group setVariable["GMSAI_lastEvaluated",diag_tickTime];
					GMSAI_infantryGroups pushBack _element;		
					if (GMSAI_debug > 1) then
					{
						_groupMarker setMarkerPos (position _leader);
						_groupMarker setMarkerText format["%1 / %2 units",_group,count units _group];			
					};
				};
			};
		};
	} else {
		if (true) exitWith {};
	};
};
