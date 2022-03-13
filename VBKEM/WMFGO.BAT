@echo off
REM ----------------------- Initial Arguments --------------------------
    set Ver=V002
    set Func=Dos_WMFG_IN_GOING
    aset.exe BatchFile=locase(dir+'\%0')
    if @%SETLOG%==@1 call setlog.bat start "%BatchFile%" %Ver%

REM ----------------------- Main Program -----------------------------
 
 inifile.com \@control.ini [SFCS] Project >out.bat
    call out.bat
 if not @%Project%==@91.4WX01 goto End

 if @%MbModel@%==@ call \func\equ\getmbmdl.bat
 if not @%mbmodel@%==@E49WW goto End 

:Start
  ::-- Delete Ser
    boxinmfg d
  ::-- Write MFG_IN_Going
    boxinmfg w
if errorlevel 1 goto WFail
  ::-- Check 
    boxinmfg r | find /i "MFG_IN_GOING" >nul
if errorlevel 1 goto WFail
goto End

REM ----------------------- Fail Message -----------------------------
:WFail
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% Write_MFGINGOING_NG 
    call ng.bat WMFGGONG
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto Start

REM ----------------------- End & Clear Temporary Data ---------------
:End
    if %SETLOG%==1 call setlog.bat end "%BatchFile%"
    set Ver=
    set Func=
    set BatchFile=

