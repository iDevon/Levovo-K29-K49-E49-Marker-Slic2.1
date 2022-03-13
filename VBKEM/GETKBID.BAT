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
    set KBID@=Unknow
    kbid.exe /rkb_id | find /i "This is UK" >nul
    if not errorlevel 1 set KbID@=00
    kbid.exe /rkb_id | find /i "This is BZ" >nul
    if not errorlevel 1 set KbID@=01
    kbid.exe /rkb_id | find /i "This is JP" >nul
    if not errorlevel 1 set KbID@=02
    kbid.exe /rkb_id | find /i "This is US" >nul
    if not errorlevel 1 set KbID@=03
goto End

:MBD
    mbd /Rh 2A 01 | lmod KbID@=[] | aset /f
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
    inifile.com \@control.ini [ID] KbID@=%KbID@%
    echo KB ID: [1;32m%KbID@%[0m
