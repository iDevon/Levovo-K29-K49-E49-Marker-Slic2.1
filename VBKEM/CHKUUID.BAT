@echo off
REM ----------------------- Initial Arguments --------------------------
    set Ver=V004
    set Func=Dos_Chk_UUID
    aset.exe BatchFile=locase(dir+'\%0')
    if @%SETLOG%==@1 call setlog.bat start "%BatchFile%" %Ver%

REM ----------------------- Main Program -------------------------------
  ::-- Check UUID
    if @%MAC8%==@ call \func\lanid\getlanid.bat
    inifile.com %Drv%\%MAC8%.AAA [SFC] SFCSUUID >out.bat
    call out.bat
    call getuuid.bat
    ck_ibmsr %UUID%
if errorlevel 1 goto UUID_NG
    aset.exe -n -e len=len('@%UUID%') eq 32+1
if not errorlevel 1 goto UUID_NG
    aset.exe -n -e ans=pos('000000','%UUID%@')
if errorlevel 1 goto UUID_NG
    aset.exe -n -e ans=pos('FFFFFF','%UUID%@')
if errorlevel 1 goto UUID_NG

    if @%Mainbatch%==@\fgfunc.bat  goto end
    if @%Mainbatch%==@\shlfunc.bat goto end 
    if @%SFCSUUID%==@NA goto end
    if @%SFCSUUID%==@   goto end

    if not @%SFCSUUID%==@NA aset.exe -n -e ans=%UUID% eq %SFCSUUID%
    if not @%SFCSUUID%==@NA if not errorlevel 1 goto UUID_NG

goto End                                                

REM ----------------------- Fail Message -----------------------------
:UUID_NG
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% Chk_UUID_NG "%UUID%"
    call ng.bat CUUIDNG
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto UUID_NG

:SFCUUID_NG
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% Chk_UUID_NG "%UUID%"
    call ng.bat SFCUUID_NG
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto SFCUUID_NG

REM ----------------------- End & Clear Temporary Data ---------------
:End
    if @%SETLOG%==@1 call setlog.bat end "%BatchFile%" %Ver%
    set Ver=
    set Func=
    set BatchFile=
