@echo off
REM ----------------------- Initial Arguments --------------------------
    set Ver=V001
    set Func=Dos_Write_BuildDate
    aset.exe BatchFile=locase(dir+'\%0')
    if @%SETLOG%==@1 call setlog.bat start "%BatchFile%" %Ver%

REM ----------------------- Main Program -----------------------------
:Start
    cfgupdt W /BLDDATE=RTC
if errorlevel 1 goto WFail
goto End

REM ----------------------- Fail Message -----------------------------
:WFail
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% Write_BuildDate_NG 
    call ng.bat WBLDDATENG
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto Start

REM ----------------------- End & Clear Temporary Data ---------------
:End
    if %SETLOG%==1 call setlog.bat end "%BatchFile%"
    set Ver=
    set Func=
    set BatchFile=

