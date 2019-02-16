params["_unit","_killer","_isLegal"];
diag_log format["[GMSAI] processUnitKilled: typeOf _killer = %1  |  typeOf _killer = %2",typeOf _killer, typeOf _killer];
_unit setVariable ["GMSAI_deleteAt", (diag_tickTime) + GMSAI_bodyDeleteTimer];
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
	[_unit,["Reloaded"]] call GMS_fnc_removeEventHandlers;
	if (GMSAI_removeNVG) then
	{
		[_unit] call GMS_fnc_removeNVG;
	};
	if (GMSAI_launcherCleanup) then
	{
		[_unit] call GMS_fnc_removeLauncher;
	};
	if (_isLegal) then
	{
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
};
/*
		things that have to happen are:

		Generic
		remove unit from group; delete group if empty.
		set unit cleanup timer
		1. determine if the killer is a player and if not don't send a reward.
		2. remove any NVG or launchers if appropriate.

		Infantry
		3. determine if the death is due to a runover situation that is prohibited; 
			If so, move the unit a bit and set damage to 0.
			else
				 message players with kill messages if appropriate
				send player respect, crypto or tabs if appropriate

		4. Aircraft 
			Test if aircraft crew all dead and if so set to lock to "UNLOCKED"

*/