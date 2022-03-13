@echo off
REM ----------------------- Initial Arguments --------------------------
    set Ver=V002
    set Func=Dos_Chk_KBID
    aset.exe BatchFile=locase(dir+'\%0')
    if @%SETLOG%==@1 call setlog.bat start "%BatchFile%" %Ver%

REM ----------------------- Main Program -------------------------------
:Start
  ::-- Set KBID
    inifile.com \@control.ini [ID] KB>out.bat
    call out.bat
    if @%KB%==@UK set KbID=00
    if @%KB%==@BZ set KbID=01
    if @%KB%==@JP set KbID=02
    if @%KB%==@US set KbID=03
if @%KbID%==@ goto NoKbID

  ::-- Check KBID
    call getkbid.bat
if not @%KbID%==@%KbID@% goto KbID_NG 
goto End

REM ----------------------- Fail Message -----------------------------
:NoKbID
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% No_KbID
    call ng.bat NoKbID
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto NoKbID

:KbID_NG
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% Chk_KbID_NG "%KbID%" "%KbID@%"
    call ng.bat CKBIDNG
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto KbID_NG

REM ----------------------- End & Clear Temporary Data ---------------
:End
    if @%SETLOG%==@1 call setlog.bat end "%BatchFile%" %Ver% "%KbID%" "%KbID@%"
    set Ver=
    set Func=
    set BatchFile=
    set KbID=
    set KbID@=
