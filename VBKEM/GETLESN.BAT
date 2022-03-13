@echo off
REM ------------------------- Main Program -----------------------------
  ::-- Check Model
    inifile \func\nvs\serial.ini [%Model%] NvsType>out.bat
    call out.bat
if not @%NvsType%==@ goto %NvsType%
    inifile \func\nvs\serial.ini [%MbModel@%] NvsType>out.bat
    call out.bat
if not @%NvsType%==@ goto %NvsType%
goto NoModel

:SmbSN
    call getsmbs.bat >nul
goto End

:MBD
    mbd.exe /Rs 90 40 | lmod LeSn@=[] | aset /f
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
    inifile.com \@control.ini [ID] LeSn@=%LeSn@%
    echo Lenovo Sn: [1;32m%LeSn@%[0m
