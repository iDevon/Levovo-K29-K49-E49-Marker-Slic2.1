@echo off
REM ----------------------- Initial Parameter --------------------------
    set Ver=V002
    set Func=Dos_UuidHr
    aset.exe BatchFile=locase(dir+'\%0')
    if @%SETLOG%==@1 call setlog.bat start %BatchFile% %Ver%

REM ----------------------- Main Program -------------------------------
  ::-- Get UUID HR
    set UuidHr=
   cd\func\vrfid
   call getuuid.bat
    echo %uuid% | lmod.com UuidHr='[1,2][3,2][5,2][7,2]-[9,2][11,2]-[13,2][15,2]-[17,4]-[21]' | aset.exe /f
    aset.exe /e /n ans=len('%UuidHr%') eq 36
if not errorlevel 1 goto Len_NG
    aset.exe /e /n ans=pos('00000','%UuidHr%')
if errorlevel 1 goto UuHr_NG
    echo UUID_HR  [1;32m%UuidHr%[0m
goto End

REM ----------------------- Fail Message -------------------------------
:Len_NG
    if @%SETLOG%==@1 call setlog.bat fail %BatchFile% %Ver% UuidHr_Len_NG %UuidHr%
    call ng.bat Uuhr_LenNG
    play%IGNORENG%.exe 15 11 0 15 11 0
if errorlevel 1 goto End
goto Len_NG

:UuHr_NG
    if @%SETLOG%==@1 call setlog.bat fail %BatchFile% %Ver% UuidHr_NG %UuidHr%
    call ng.bat Uuhr_NG
    play%IGNORENG%.exe 15 11 0 15 11 0
if errorlevel 1 goto End
goto UuHr_NG

REM ------------- End of batch & Clear temporary variable --------------
:End
    if @%SETLOG%==@1 call setlog.bat end %BatchFile% %Ver% %SP_UuHr% %UuidHr%
    inifile.com \@control.ini [ID] UuidHr=%UuidHr%
    set Func=
    set BatchFile=
    set Ver=