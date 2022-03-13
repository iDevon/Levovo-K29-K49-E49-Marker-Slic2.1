REM ----------------------- Main Program -------------------------------
  ::-- Check Model
    inifile \func\nvs\serial.ini [%Model%] NvsType>out.bat
    call out.bat
if not @%NvsType%==@ goto %NvsType%
    inifile \func\nvs\serial.ini [%MbModel@%] NvsType>out.bat
    call out.bat
if not @%NvsType%==@ goto %NvsType%
goto NoModel

:SmbSN
    smbsn /wsn "                         "
    smbsn /wsn "%s%"
goto End

:MBD
    mbd.exe /Wh 40 00000000000000000000000000000000
    mbd.exe /Wh 50 00000000000000000000000000000000
    mbd.exe /Ws 40 "%s%"
    mbd.exe /CHK 40 20
goto End

REM ----------------------- Fail Message -----------------------------
:NoModel
    set BatchFile=\func\nvs\wser.bat
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% AddNvsType
    call ng.bat ADDNVSTYPE
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto NoModel

REM ----------------------- End & Clear Temporary Data ---------------
:End
