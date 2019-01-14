private _1sec = diag_tickTime;
private _5sec = diag_tickTime;
private _15sec = diag_tickTime;

while {true} do
{
    uiSleep 1;
    if (diag_tickTime > _5sec) then
    {
        _5sec = diag_tickTime + 5;
        call GMSAI_fnc_monitorInactiveAreas;
        call GMSAI_fnc_monitorActiveAreas;
        call GMSAI_fnc_dynamicAIManager;
        call GMSAI_fnc_infantryGroupMonitor;
    };
};