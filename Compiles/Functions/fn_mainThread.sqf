private _1sec = diag_tickTime;
private _5sec = diag_tickTime;
private _15sec = diag_tickTime;
private _60sec = diag_tickTime;

while {true} do
{
    uiSleep 1;
    if (diag_tickTime > _5sec) then
    {
        call GMSAI_fnc_monitorInfantryGroups;       
        call GMSAI_fnc_monitorInactiveAreas;
        call GMSAI_fnc_monitorActiveAreas;
        //diag_log format["_mainThread: calling GMSAI_fnc_dynamicAIManager at %1",diag_tickTime];
        call GMSAI_fnc_dynamicAIManager;
        _5sec = diag_tickTime + 5;
    };
    if (diag_tickTime > _60sec) then
    {
       //diag_log format["_mainThread: calling GMSAI_fnc_monitorAirPatrols at %1",diag_tickTime];
        call GMSAI_fnc_monitorAirPatrols;
        call GMSAI_fnc_monitorUAVPatrols;
        call GMSAI_fnc_monitorVehiclePatrols;
        //call GMSAI_fnc_monitorInfantryPatrols;
        call GMSAI_fnc_monitorEmptyVehicles;
        call GMSAI_fnc_monitorDeadUnits;
        _60sec = diag_tickTime + 60;
    };
};