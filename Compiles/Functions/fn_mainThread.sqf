private _1sec = diag_tickTime;
private _5sec = diag_tickTime;
private _15sec = diag_tickTime;
private _60sec = diag_tickTime;

while {true} do
{
    uiSleep 1;
    if (diag_tickTime > _5sec) then
    {
        _5sec = diag_tickTime + 5;
        call GMSAI_fnc_infantryGroupMonitor;        
        call GMSAI_fnc_monitorInactiveAreas;
        call GMSAI_fnc_monitorActiveAreas;
        //diag_log format["_mainThread: calling GMSAI_fnc_dynamicAIManager at %1",diag_tickTime];
        call GMSAI_fnc_dynamicAIManager;

    };
    if (diag_tickTime > _60sec) then
    {
       //diag_log format["_mainThread: calling GMSAI_fnc_monitorAirPatrols at %1",diag_tickTime];
        call GMSAI_fnc_monitorAirPatrols;
        call GMSAI_fnc_monitorInfantryGroups;
        _60sec = diag_tickTime + 60;
    };
};