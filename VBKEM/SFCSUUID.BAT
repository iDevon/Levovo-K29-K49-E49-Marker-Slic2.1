@echo off
REM ----------------------- Initial Arguments --------------------------
    set Ver=V002
    set Func=Dos_SFCS_UUID
    aset.exe BatchFile=locase(dir+'\%0')
    if @%SETLOG%==@1 call setlog.bat start "%BatchFile%" %Ver%

REM ----------------------- Main Program -------------------------------
  ::-- Get Sfcs UUID
    inifile.com \@control.ini [SFCS] Sfcs_SfcsUUID >out.bat
    call out.bat
    call getuuid.bat
if @%Sfcs_SfcsUUID%==@       goto End
if @%Sfcs_SfcsUUID%==@NA     goto End
if @%Sfcs_SfcsUUID%==@%UUID% goto End

  ::-- Check Model
    inifile \func\nvs\serial.ini [%Model%] NvsType>out.bat
    call out.bat
if not @%NvsType%==@ goto %NvsType%
    inifile \func\nvs\serial.ini [%MbModel@%] NvsType>out.bat
    call out.bat
if not @%NvsType%==@ goto %NvsType%
goto NoModel

:SmbSN
    autouuid.exe xxx /d:%Sfcs_SfcsUUID%
    call getuuid.bat
goto Check

:MBD
    mbd.exe /Wh E0 00000000000000000000000000000000
    mbd.exe /Wh E0 %Sfcs_SfcsUUID%
goto Check

:Check
if @%UUID%==@%Sfcs_SfcsUUID% goto End
goto Fail

REM ----------------------- Fail Message -----------------------------
:NoModel
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% AddNvsType
    call ng.bat ADDNVSTYPE
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto NoModel

:Fail
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% Write_SFCS_UUID_NG
    call ng.bat WUUIDNG
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto %NvsType%

REM ----------------------- End & Clear Temporary Data ---------------
:End
    if @%SETLOG%==@1 call setlog.bat end "%BatchFile%" %Ver% %Sfcs_SfcsUUID% %UUID%
    set Ver=
    set Func=
    set BatchFile=
    set Sfcs_SfcsUUID=
    set UUID=
