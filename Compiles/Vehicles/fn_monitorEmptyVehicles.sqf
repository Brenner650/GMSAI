for "_i" from 1 to (count GMSAI_emptyVehicles) do
{
	private _v = GMSAI_emptyVehicles deleteAt 0;
	if (owner _v == 2) then
	{
		if (_v getVariable "GMSAI_deleteAt") then
		{
			deleteVehicle _v;
		} else {
			GMSAI_emptyVehicles pushBack _v;
		};
	};
};