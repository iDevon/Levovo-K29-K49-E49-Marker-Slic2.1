@echo off
REM ------------------------- Main Program -----------------------------
  ::-- Check Model
call model.bat

if @%PartNo@%==@4UG01 goto Srfid
if @%PartNo@%==@4UH01 goto Srfid

goto smbsn
    inifile \func\nvs\serial.ini [%Model%] NvsType>out.bat
    call out.bat
if not @%NvsType%==@ goto %NvsType%
    inifile \func\nvs\serial.ini [%MbModel@%] NvsType>out.bat
    call out.bat
if not @%NvsType%==@ goto %NvsType%
goto NoModel

:SmbSN
    vrfid.exe /ruuid | find /i "UUID" | lmod /s: uuid=[$2] | aset /f
goto End

:MBD
    mbd.exe /Rh E0 10 | lmod uuid=[] | aset /f
goto End

:SRfid
    rfid.exe /Rsh ac 12 10 | lmod uuid=[] | aset /f
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
    inifile.com \@control.ini [ID] uuid=%uuid%
    echo UUID: [1;32m%uuid%[0m
