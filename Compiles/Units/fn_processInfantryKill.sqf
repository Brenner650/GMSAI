params["_unit","_killer"];
private _isLegal = true;
diag_log format["[GMSAI] processUnitKilled: typeOf _killer = %1  |  typeOf _killer = %2",typeOf _killer, typeOf _killer];
if (isPlayer _killer && GMSAI_runoverProtection && vehicle _killer isEqualTo _killer) exitWith
{
	_unit setDamage 0;	
	_isLegal = false;

};
[_unit,_killer,_isLegal] call GMSAI_fnc_processUnitKill;

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