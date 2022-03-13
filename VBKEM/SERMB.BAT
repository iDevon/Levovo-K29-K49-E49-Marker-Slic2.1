@echo off
REM ----------------------- Initial Arguments --------------------------
    set Ver=V002
    set Func=Dos_MBSN
    aset.exe BatchFile=locase(dir+'\%0')
    if @%SETLOG%==@1 call setlog.bat start "%BatchFile%" %Ver%

REM ----------------------- Main Program -------------------------------
  ::-- Get MB S/N
    inifile.com \@control.ini [SFCS] Sfcs_Sfcs11SN >out.bat
    call out.bat
if @%Sfcs_Sfcs11SN%==@ goto No11S

:Flash
  ::-- Write MB S/N
    wmbser.bat
if errorlevel 1 goto Fail

  ::-- Check MB S/N
    call getmbsn.bat
if not @%Sfcs_Sfcs11SN%==@11S%MB11S@% goto Fail
goto End

REM ----------------------- Fail Message -----------------------------
:No11S
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% NO_11S
    call ng.bat NO11S
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto No11S

:Fail
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% Write_MBSN_NG %Sfcs_Sfcs11SN% %MB11S@%
    call ng.bat W11SNNG
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto Input

REM ----------------------- End & Clear Temporary Data ---------------
:End
    if @%SETLOG%==@1 call setlog.bat end "%BatchFile%" %Ver%
    if exist out.bat del out.bat
    set Func=
    set Ver=
    set BatchFile=
    set Sfcs_Sfcs11SN=
    set Mb11S@=
