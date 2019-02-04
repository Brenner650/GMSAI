params["_unit","_killer"];
diag_log format["[GMSAI] unitKilled_EH: typeOf _killer = %1  |  typeOf _killer = %2",typeOf _killer, typeOf _killer];
//private _isRunover = if () then {false} else {true};
if (isPlayer _killer && GMSAI_runoverProtection && vehicle _killer isEqualTo _killer) exitWith
{
	_unit setDamage 0;	
	//  apply vehicle damage
	//    scenario 1: add to global damaga by some amount which could be random within a range.
	//    scnario 2: add to damage at randomly selected hitpoints by some amount which could be random within a certain range.
};
_unit setVariable ["GMSAI_cleanupAt", (diag_tickTime) + GMSAI_bodyCleanUpTimer, true];
GMSAI_deadAI pushback _unit;
private _group = group _unit;
[_unit] joinSilent grpNull;
if (count(units _group) < 1) then 
{
	deleteGroup _group;
};
if (isPlayer _killer) then 
{
	[_unit,["MPKilled","MPHit"]] call GMS_fnc_removeMPEventHandlers;
	if (GMSAI_removeNVG) then
	{
		[_unit] call GMS_fnc_removeNVG;
	};
	if (GMSAI_launcherCleanup) then
	{
		[_unit] call GMS_fnc_removeLauncher;
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
};
/*
		things that have to happen are:
		remove unit from group; delete group if empty.
		set unit cleanup timer
		1. determine if the killer is a player and if not done send a reward.
		2. remove any NVG or launchers if appropriate.
		3. determine if the death is due to a runover situation that is prohibited; 
			If so, move the unit a bit and set damage to 0.
			else
				 message players with kill messages if appropriate
				send player respect, crypto or tabs if appropriate

*/