@echo off
REM ----------------------- Initial Arguments --------------------------
    set Ver=V003
    set Func=Dos_SLP2_%1
    aset.exe SlpArg=upcase('%1')
    set BatchFile=\func\slp2\slp2.bat %1
    if @%SETLOG%==@1 call setlog.bat start "%BatchFile%" %Ver%

REM ----------------------- Main Program -------------------------------
  ::-- SLP2 Maker File
    set OA21=MARK21.BIN

  ::-- Check Arg
if @%SlpArg%==@DIS goto Slp2Dis
if @%SlpArg%==@EN  goto Slp2En
if @%SlpArg%==@CHK goto Slp2Chk
goto AddArg
    
  ::-- Set slp2 enable
:Slp2En
    slputil.exe chkmark %OA21% >nul
if not errorlevel 1 goto End
    slputil.exe setmark %OA21% >nul
if errorlevel 1 goto SetEnNG

  ::-- Check slp2 enable
:ChkEn
    slputil.exe chkmark %OA21% >nul
if errorlevel 1 goto ChkEnNG
goto End

  ::-- Set slp2 disable
:Slp2Dis
    slputil clrmark >nul
    wait 1
    slputil clrmark | find /i "Marker has been cleared" >nul
if errorlevel 1 goto SetDisNG

  ::-- Check slp2 disable
:Chkdis
    slputil.exe chkmark %OA21% >nul
if not errorlevel 1 goto ChkDisNG
goto End

REM ----------------------- Fail Message -------------------------------

:SetEnNG
message0 12 "set NG"
pause
goto SetEnNG

:SetDisNG
message0 12 "dis NG"
 pause
goto SetDisNG

:ChkEnNG
message0 12 "EN NG"
pause
goto ChkEnNG

:ChkDisNG
message0 12 "DIS NG"
 pause
goto ChkDisNG

REM ----------------------- End & Clear Temporary Data ---------------
:End
    if @%SETLOG%==@1 call setlog.bat end "%BatchFile%" %Ver%
    if exist out.bat del out.bat
    set Ver=
    set Func=
    set BatchFile=
    set OA21=
    set SlpArg=
    set Sfcs_Image_Pn=
