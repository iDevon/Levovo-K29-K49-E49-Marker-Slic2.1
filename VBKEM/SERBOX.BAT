@echo off
REM ----------------------- Initial Arguments --------------------------
    set Ver=V003
    set Func=Dos_BoxSN
    aset.exe BatchFile=locase(dir+'\%0')
    if @%SETLOG%==@1 call setlog.bat start "%BatchFile%" %Ver%

REM ----------------------- Main Program -------------------------------
  ::-- Read Serial Number
    call getboxsn.bat
    if not @%BoxSN%==@ set Ser1=%BoxSN%

:Input
    play.exe 5 41
    textmode.com
    set S=
    wbat text 2,1 (+white on black) @serial.ini:serial
    call w.bat box 13,22 (blue on +cyan) @serial.ini:input
    set Ser1=%S%
    play.exe 4
    cls
  ::-- Input null goto Input
if @%S%==@ goto Input
  ::-- If Input special image name, goto End
    set SpImage=
    find /i "[%S%]" serial.ini >nul
if errorlevel 1 goto Next
    set SpImage=%S%
    inifile.com serial.ini [%s%] >out.bat
    call out.bat
goto End

:Next
  ::-- Get Input S/N Head
    aset SerHead@=left('%S%@',2)
  ::-- Get S/N Length
    find /i "[%SerHead@%]" serial.ini >nul
if     errorlevel 1 set SerLength=16
if not errorlevel 1 inifile.com serial.ini [%SerHead@%] >out.bat
if not errorlevel 1 call out.bat
  ::-- Check S/N is correct number & letter
    ck_ibmsr %S%
if errorlevel 1 goto IDNG
  ::-- Check S/N length
    aset.exe -n -e len=len('@%S%') eq %SerLength%+1
if errorlevel 1 goto Flash
goto IDNG

:Flash
  ::-- Write S/N
    call wser.bat

  ::-- Check S/N
    call getboxsn.bat
if not @%S%==@%BoxSn% goto Fail
goto End

REM ----------------------- Fail Message -----------------------------
:IDNG
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% Input_S/N_NG %S%
    cls
    echo [2;0H[1;31m
    textecho.exe -s -lightred "¥ÌŒÛ–Ú¡–∫≈"
    locate.com 12 28
    vtmagic.com /P À¢¥ÌµƒÃı¬Î «: %S%[0m
    play.exe 9 15 11 0 0 0
goto Input

:Fail
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% Write_S/N_NG %S% %BoxSn%
    call ng.bat WRITESNNG
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto Input

REM ----------------------- End & Clear Temporary Data ---------------
:End
    if @%SETLOG%==@1 call setlog.bat end "%BatchFile%" %Ver% %S%
    if exist out.bat del out.bat
    set Func=
    set Ver=
    set BatchFile=
    set Ser1=
    set Ser2=
    set S=
    set SerHead@=
    set SerLength=
