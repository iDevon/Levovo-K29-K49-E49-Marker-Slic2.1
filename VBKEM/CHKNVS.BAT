@echo off
REM ----------------------- Main Program -------------------------------
    cls
    echo [2;0H
    textecho -s -brightwhite "¼ì²éNVS"

  ::-- Common Check Item
    call chkpname.bat
    call chkuuid.bat

  ::-- Check Model
    inifile \func\nvs\serial.ini [%Model%] NvsType>out.bat
    call out.bat
if not @%NvsType%==@ goto %NvsType%
    inifile \func\nvs\serial.ini [%MbModel@%] NvsType>out.bat
    call out.bat
if not @%NvsType%==@ goto %NvsType%
goto NoModel

:SmbSN
    if not @%PN5%==@1S168 call chksmbs.bat
    call chkkbid.bat
    call chkestar.bat
goto End

REM ----------------------- Fail Message -------------------------------
:NoModel
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% AddNvsType
    call ng.bat ADDNVSTYPE
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto NoModel

REM ----------------------- End & Clear Temporary Data -----------------
:End
