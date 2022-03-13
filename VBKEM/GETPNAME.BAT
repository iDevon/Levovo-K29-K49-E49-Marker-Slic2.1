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
    cfgupdt.exe r /brandname | find.exe /i "Brand name" | lmod.com /s set ProdName@=[$3] [$4] [$5]>out.bat
    call out.bat
goto End

:MBD
    mbd /Rs 60 1F | lmod set ProdName@=[] >out.bat
    call out.bat
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
    if exist out.bat del out.bat
    inifile.com \@control.ini [ID] ProdName@=%ProdName@%
    echo Product Name: [1;32m%ProdName@%[0m
