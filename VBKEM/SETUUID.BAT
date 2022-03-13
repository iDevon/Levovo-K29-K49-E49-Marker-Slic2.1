@echo off
REM ----------------------- Initial Arguments --------------------------
    set Ver=V002
    set Func=Dos_UUID
    aset.exe BatchFile=locase(dir+'\%0')
    if @%SETLOG%==@1 call setlog.bat start "%BatchFile%" %Ver%
    set nvstype=SmbSN
REM ----------------------- Main Program -------------------------------
  ::-- Check Model
goto smbsn
    inifile \func\nvs\serial.ini [%Model%] NvsType>out.bat
    call out.bat
if not @%NvsType%==@ goto %NvsType%
    inifile \func\nvs\serial.ini [%MbModel@%] NvsType>out.bat
    call out.bat
if not @%NvsType%==@ goto %NvsType%
goto NoModel

:SmbSN
    autouuid.exe xxx /d:00000000000000000000000000000000
    autouuid.exe
if errorlevel 1 goto Fail
goto Check

:MBD
    uuid.exe /c | lmod set uuid@=[] >out.bat
    mbd.exe /Wh E0 00000000000000000000000000000000
    mbd.exe /Wh E0 %uuid@%
goto Check

:Check
    call getuuid.bat
    ck_ibmsr %UUID%
if errorlevel 1 goto UUID_NG
    aset.exe -n -e len=len('@%UUID%') eq 32+1
if not errorlevel 1 goto UUID_NG
    aset.exe -n -e ans=pos('000000','%UUID%@')
if errorlevel 1 goto UUID_NG
    aset.exe -n -e ans=pos('FFFFFF','%UUID%@')
if errorlevel 1 goto UUID_NG
goto End

REM ----------------------- Fail Message -----------------------------
:NoModel
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% AddNvsType
    call ng.bat ADDNVSTYPE
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto NoModel

:Fail
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% Write_UUID_NG
    call ng.bat WUUIDNG
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto %NvsType%

:UUID_NG
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% Chk_UUID_NG "%UUID%"
    call ng.bat CUUIDNG 1
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto %NvsType%

REM ----------------------- End & Clear Temporary Data ---------------
:End
    if @%SETLOG%==@1 call setlog.bat end "%BatchFile%" %Ver% %uuid%
    set Ver=
    set Func=
    set BatchFile=
    set uuid@=
