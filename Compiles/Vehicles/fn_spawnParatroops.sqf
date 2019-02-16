params["_aircraft"];
private _group = [[0,0,0],[GMSAI_numberParatroops] call GMS_fnc_getIntegerFromRange,0] call GMS_fnc_spawnInfantryGroup;

private _difficulty = selectRandomWeighted GMSAI_paratroopDifficulty;
[_group,GMSAI_unitDifficulty select (_difficulty)] call GMS_fnc_setupGroupSkills;
[_group, GMSAI_unitLoadouts select _difficulty, 0 /* launchers per group */, GMSAI_useNVG, GMSAI_blacklistedGear] call GMS_fnc_setupGroupGear;
[_group,_difficulty,GMSAI_money] call GMS_fnc_setupGroupMoney;
[_group] call GMS_fnc_setupGroupBehavior;
{
	_x addMPEventHandler ["MPKilled", {_this call GMSAI_fnc_EH_crewKilledHeli;}];
	_x addMPEventHandler ["MPHit", {_this call GMSAI_fnc_EH_crewHitHeli;}];
} forEach (units _group);
private _bb = boundingBoxReal _aircraft;
_bb params["_b1","_b2"];
private _length = abs((_p2 select 1) - (_p1 select 1));
{
	_spawnPos = (getPosATL _aircraft) getPos[10,(getDir _aircraft) + 180];
	_chute = createVehicle ["Steerable_Parachute_F", [_spawnPos select 0, _spawnPos select 1, (getPosATL _aircraft) select 2], [], 0, "FLY"];
	_x assignAsDriver _chute;
	_x moveInDriver _chute;
	uiSleep 2;
} forEach (units _group);