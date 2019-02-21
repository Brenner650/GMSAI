
for "_i" from 1 to (count GMSAI_deadAI) do
{
	_v = GMSAI_deadAI deleteAt 0;
    if (_i > (count GMSAI_deadAI)) exitWith {};
    if (diag_tickTime > _v getVariable "GMSAI_deleteAt") then 
	{
			deleteVehicle _v;
	} else {
		GMSAI_deadAI pushBack _v;
	};
};