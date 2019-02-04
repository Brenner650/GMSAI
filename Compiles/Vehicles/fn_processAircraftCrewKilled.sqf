params["_unit","_killer"];
diag_log format["[GMSAI] unitKilled_EH: typeOf _killer = %1  |  typeOf _killer = %2",typeOf _killer, typeOf _killer];
if !(isPlayer _killer) exitWith {};
	private _isRunover = if (vehicle _killer isEqualTo vehicle _killer) then {false} else {true};
if (GMSAI_runoverProtection && _isRunover) then
{
	_unit setDamage 0;	
	//  apply vehicle damage
	//    scenario 1: add to global damaga by some amount which could be random within a range.
	//    scnario 2: add to damage at randomly selected hitpoints by some amount which could be random within a certain range.
} else {
	[_unit,["MPKilled","MPHit"]] call GMS_fnc_removeMPEventHandlers;
	if (GMSAI_removeNVG) then
	{
		[_unit] call GMS_fnc_removeNVG;
	};
	if (GMSAI_launcherCleanup) then
	{
		[_unit] call GMS_fnc_removeLauncher;
	};
	_unit setVariable ["GMSAI_cleanupAt", (diag_tickTime) + GMSAI_bodyCleanUpTimer, true];
	GMSAI_deadAI pushback _unit;
	private _group = group _unit;
	[_unit] joinSilent grpNull;
	if (count(units _group) < 1) then 
	{
		deleteGroup _group;
	};
	_lastkill = _killer getVariable["GMSAI_timeOfLastkill",diag_tickTime];
	_killer setVariable["GMSAI_timeOfLastkill",diag_tickTime];
	_kills = (_killer getVariable["GMSAI_kills",0]) + 1;
	if ((diag_tickTime - _lastkill) < 240) then
	{
		_killer setVariable["GMSAI_kills",_kills];
	} else {
		_killer setVariable["GMSAI_kills",0];
	};
	//[_unit, ["Eject", vehicle _unit]] remoteExec ["action",(owner _unit)];
	if (GMSAI_useKillMessages) then
	{
		_weapon = currentWeapon _killer;
		_killstreakMsg = format[" %1X KILLSTREAK",_kills];
		private ["_message"];
		if (GMSAI_useKilledAIName) then
		{
			_message = format["%2: killed by %1 from %3m",name _killer,name _unit,round(_unit distance _killer)];
		}else{
			_message = format["%1 killed with %2 from %3 meters",name _killer,getText(configFile >> "CfgWeapons" >> _weapon >> "DisplayName"), round(_unit distance _killer)];
		};
		_message =_message + _killstreakMsg;
		[["aikilled",_message],allPlayers] call GMS_fnc_messageplayers;
	};
	[_unit,_unit distance _killer] call GMSAI_fnc_rewardPlayer;