private _1sec = diag_tickTime;
private _5sec = diag_tickTime;
private _15sec = diag_tickTime;

while {true} do
{
    uiSleep 1;
    if (diag_tickTime > _5sec) then
    {
        _5sec = diag_tickTime + 5;
        call GMSAI_monitorInactiveAreas;
        call GMSAI_monitorActiveAreas;
        call GMSAI_dynamicAIManager;
        call GMSAI_infantryGroupMonitor;
    };
};