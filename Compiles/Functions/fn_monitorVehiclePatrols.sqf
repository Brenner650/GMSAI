diag_log format["[GMSAI] _monitorVehiclePatrols called at %1",diag_tickTime];
for "_i" from 1 to (count GMSAI_vehiclePatrols) do
{
	if (_i > (count GMSAI_vehiclePatrols)) exitWith {};
	private _vehiclePatrol = GMSAI_vehiclePatrols deleteAt 0;
	_vehiclePatrol params["_crewGroup","_vehicle","_lastSpawned","_timesSpawned","_respawnAt"];  //,"_spawned"];
	if (_lastSpawned > 0) then
	{
		private _countUnits = {alive _x} count (units _crewGroup);
		private _countCrew = {alive _x} count (crew _vehicle);
		if ( (_countCrew > 0) && (alive _vehicle)) then
		{
			//diag_log format["_monitorVehiclePatrols: checking vehicle %1 with %2 alive crew located at %3 with speed of %4",_vehicle,{alive _x} count (crew _vehicle),getPos _vehicle,speed _vehicle];
			if (diag_tickTime > (_crewGroup getVariable "timestamp") + 600) then
			{
				diag_log format["_monitorVehiclePatrols: vehicle %1 delayed in arriving at WP, re-directing it",_vehicle];
				(leader _crewGroup) call GMSAI_fnc_nextWaypointVehicle;
			};
			GMSAI_vehiclePatrols pushBack _vehiclePatrol;
		} else {
			//diag_log format["_monitorVehiclePatrols: vehicle patrol killed or disabled, configuring it for respawn"];
			if (_countUnits > 0 && _countCrew == 0) then // All of the units have left the vehicle, setup some monitoring for the left-over group
			{
				//diag_log format["_monitorVehiclePatrols: Some crew alive, setting them up to patrol the area idependently"];
				private _patrolArea = createMarkerLocal[format["GMSAI_remnant%1",_crewGroup],getPos _vehicle];
				private _nearPlayers = nearestObjects[position (leader _crewGroup),["Man"],150] select {isPlayer _x};
				//diag_log format["_monitorVehiclePatrols: _nearPlayers = %1",_nearPlayers];
				{
					_crewGroup reveal[_x,1];
				}forEach _nearPlayers;
				_patrolArea setMarkerShapeLocal "RECTANGLE";
				_patrolArea setMarkerSizeLocal [150,150];
				_crewGroup setVariable["GMSAI_patrolArea",_patrolArea];
				_crewGroup setVariable["GMSAI_deleteAt",diag_tickTime + 120];
				private _m = "";
				if (GMSAI_debug >= 1) then
				{
					_m = createMarker[format["GMSAI_dynamicMarker%1",random(1000000)],getPos (leader _crewGroup)];
					_m setMarkerType "mil_triangle";
					_m setMarkerColor "COLORYELLOW";
					_m setMarkerText format["%1:%2",_crewGroup,{alive _x} count units _crewGroup];
					_m setMarkerPos getPos(leader _crewGroup);
					//diag_log format["[GMSAI] infantry group debug marker %1 created at %2",_m,markerPos _m];
				};				
				GMSAI_infantryGroups pushBack [_crewGroup,_m];
				//diag_log format["_monitorVehiclePatrols: _crewGroup %1 added to GMSAI_infantryGroups",_crewGroup];
			};
			if (alive _vehicle && _countCrew == 0) then 
			{
				if !(_vehicle in GMSAI_emptyVehicles) then
				{
					//diag_log format["_monitorVehiclePatrols: vehicle %1 still 'alive', so processing it as an empty vehicle",_vehicle];
					[_vehicle] call GMSAI_fnc_processEmptyVehicle;
				};
			};
			_vehiclePatrol set[4,diag_tickTime + ([GMSAI_vehiclePatrolRespawnTime] call GMS_fnc_getNumberFromRange)];
			_vehiclePatrol set[2,-1];
			GMSAI_vehiclePatrols pushBack _vehiclePatrol;			
		};
	} else {  // 
		//diag_log format["_monitorVehiclePatrols: _timesSpawned = %1 | _respawnAt = %2 | time = %3",_timesSpawned,_respawnAt,diag_tickTime];
		if (GMSAI_vehiclePatrolRespawns == -1 || _timesSpawned <= GMSAI_vehiclePatrolRespawns) then
		{
			if (_respawnAt > -1 && diag_tickTime > _respawnAt) then
			{
				private _pos = [0,0];
				while {_pos isEqualTo [0,0]} do
				{
					_pos = [nil,["water"]] call BIS_fnc_randomPos;
					//diag_log format["[GMSAI] _initializeVehiclePatrols: _pos = %1",_pos];
				};
				private _newPatrol = [_pos] call GMSAI_fnc_spawnVehiclePatrol;
				_vehiclePatrol set[0,_newPatrol select 0];
				_vehiclePatrol set[1,_newPatrol select 1];
				_vehiclePatrol set[2,diag_tickTime];
				_vehiclePatrol set[3,_timesSpawned + 1];
			};
			GMSAI_vehiclePatrols pushBack _vehiclePatrol;
		};
	};
	
};

/*
	Cases to consider:
	1. 1 or more crew alive and vehicle alive
	2. no crew in vehicle and vehicle alive (should have already been processed but can double-check)
		a. no units in group alive - do nothing
		b. 1 or more units in group alive, add them to the list of monitored infantry groups, set a flag on the group = "residual"
	3. _lastSpawned < 0: test for respawn conditions. 