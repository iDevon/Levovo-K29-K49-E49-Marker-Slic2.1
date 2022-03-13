@echo off
REM ----------------------- Initial Arguments --------------------------
    set Ver=V002
    set Func=Dos_KBID
    aset.exe BatchFile=locase(dir+'\%0')
    if @%SETLOG%==@1 call setlog.bat start "%BatchFile%" %Ver%

REM ----------------------- Main Program -------------------------------
:Start
  ::-- Get KBID
    inifile.com \@control.ini [ID] KB>out.bat
    call out.bat

  ::-- Check Model
    inifile \func\nvs\serial.ini [%Model%] NvsType>out.bat
    call out.bat
if not @%NvsType%==@ goto %NvsType%
    inifile \func\nvs\serial.ini [%MbModel@%] NvsType>out.bat
    call out.bat
if not @%NvsType%==@ goto %NvsType%
goto NoModel

:SmbSN
    if @%KB%==@UK set KbID=00
    if @%KB%==@BZ set KbID=01
    if @%KB%==@JP set KbID=02
    if @%KB%==@US set KbID=03
if @%KbID%==@ goto NoKbid
    kbid.exe /wkb_id %KbID%
if errorlevel 1 goto WKbID_NG
goto Check

:MBD
    if @%KB%==@UK set KbID=00
    if @%KB%==@BZ set KbID=01
    if @%KB%==@JP set KbID=02
    if @%KB%==@US set KbID=00
if @%KbID%==@ goto NoKbid
    mbd.exe /Wh 2A "%KbID%"
    mbd.exe /CHK 20 10
goto Check

:Check
    call getkbid.bat
    aset -n -e ans='@%KbID%' eq '@%KbID@%'
if not errorlevel 1 goto WKbID_NG
goto End

REM ----------------------- Fail Message -----------------------------
:NoModel
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% AddNvsType
    call ng.bat ADDNVSTYPE
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto NoModel

:NoKbID
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% No_KbID
    call ng.bat NoKbID
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto NoKbID

:WKbID_NG
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% Write_KbID_NG "%KbID%" "%KbID@%"
    call ng.bat WKBIDNG
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto Start

REM ----------------------- End & Clear Temporary Data ---------------
:End
    if @%SETLOG%==@1 call setlog.bat end "%BatchFile%" %Ver% "%KbID%" "%KbID@%"
    set Ver=
    set Func=
    set BatchFile=
    set KbID=
    set KbID@=
