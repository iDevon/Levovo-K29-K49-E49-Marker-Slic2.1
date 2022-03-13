@echo off
REM ----------------------- Initial Arguments --------------------------
    set Ver=V008
    set Func=Dos_SLP2_%1
    aset.exe SlpArg=upcase('%1')

REM ----------------------- Main Program -------------------------------

  ::-- BIOSHD
    call getbios.bat

  ::-- SLP2 Maker File
    set OA21=TP-%BiosHD@%_7.BIN

 if not exist TP-%BiosHD@%_7.bin goto nobin

  ::-- Check Arg
if @%SlpArg%==@DIS goto Slp2Dis
if @%SlpArg%==@EN  goto Slp2En
if @%SlpArg%==@CHK goto Slp2Chk
goto AddArg
    
  ::-- Set slp2 enable
:Slp2En
    ssp2 /W:%OA21%
if errorlevel 1 goto SetEnNG

  ::-- Check slp2 enable
:ChkEn
    ssp2 /m /slp2marker?
if errorlevel 1 goto ChkEnNG
goto End

  ::-- Set slp2 disable
:Slp2Dis
    ssp2 /w:nullmarker
if errorlevel 1 goto SetDisNG

  ::-- Check slp2 disable
:Chkdis
    ssp2 /m /dump
if errorlevel 37 if not errorlevel 38 goto End
goto ChkDisNG

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

:nobin
 message0 13 "no bin"
 echo [17;13H [35m there is no bin file for this model[0m
 pause
goto  nobin

REM ----------------------- End & Clear Temporary Data ---------------
:End
    if exist out.bat del out.bat
    set Ver=
    set Func=
    set BatchFile=
    set OA21=
    set SlpArg=
    set Sfcs_Image_Pn=
