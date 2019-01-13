private _mod = "Epoch";
if not ( isNull ( configFile >> "CfgPatches" >> "exile_server" ) ) then { _mod = "Exile" };
//if not ( isNull ( configFile >> "CfgPatches" >> "a3_epoch_server" ) ) then { _mod = "Epoch" };
diag_log format["[GMSAI] _getModType: _mod = %1",_mod];
_mod