@echo off
REM ----------------------- Initial Arguments --------------------------
  ::-- V026
    aset.exe Arg1=upcase('%1')
  ::-- Display help screen
    aset.exe -e -n ans=("@%Arg1%"=="@/?") or ("@%Arg1%"=="@/H")
    if errorlevel 1 help.bat ng.txt
  ::-- Set NG code File
    if not @%LANGUAGE%==@EN set VerFile=\tool\ng_sc.txt
    if     @%LANGUAGE%==@EN set VerFile=\tool\ng_us.txt
    aset.exe CD_Path=dir

REM ----------------------- Main Program -------------------------------
  ::-- Upload EWS NG Information
    find /i "@%Arg1%@" \tool\ewsng.ini>nul
if errorlevel 1 goto FindArg
    call ewslog.bat NG NG_%Arg1%

:FindArg
    find.exe /i "%Arg1%" %VerFile% >nul
if not errorlevel 1 goto Main
  ::-- if %1 is null or can't find %1 in %VerFile%
    set TE_Code=%Arg1%
    set Arg1=NO_TE_CODE

:Main
    find.exe /i "%Arg1%" %VerFile% | lmod.com /l3 set Err=[24,4][+]set info=[13,10][+]set Msg=[33,85][+]set Act=[120,55]>%drv%\out.bat
    call %drv%\out.bat

:ShowNG
  cd \
    clrkb.com
    cls
    echo [1;31m
    locate.com 0 0
    if not @%LANGUAGE%==@EN textecho.exe -s -lightred %info%
    if not @%LANGUAGE%==@EN wbat.com STDOUT @%drv%\tool\ng.ans>%drv%\out.bat
    if not @%LANGUAGE%==@EN vtmagic.com /T %drv%\out.bat
    if     @%LANGUAGE%==@EN bigtext.com /fs /sp "     %info%"
    if     @%LANGUAGE%==@EN wbat.com STDOUT @%drv%\tool\ngen.ans
  ::-- check press key to upload error to Sfcs 
  cd %CD_Path%
    wait.com %2
if errorlevel 48 if not errorlevel 49 goto NG2Sfcs
if errorlevel 56 if not errorlevel 57 goto Update
if errorlevel 57 if not errorlevel 58 goto UpNT
if errorlevel 69 if not errorlevel 70 goto EditBatch
goto end

:EditBatch
    get.exe SE
    aset Get=upcase('%Get%')
    if @%Get%==@DIT edit %BatchFile%
goto ShowNG

:NG2Sfcs
    if @%Arg1%==@NO_TE_CODE goto End
    if @%SendNG%==@1 call ng2sfcs.bat
goto End

:Update
  cd \netware
    call startnet.bat
    copy G:\%Line%\%PartNo%\%Model%\update2.bat %Drv%\  /y
    call %Drv%\update2.bat
    call %drv%\tool\uptag.bat
    wait 1
    reboot.exe
goto End

:UpNT
  cd \ntnet
    call startnt.bat
    copy G:\%Line%\%PartNo%\%Model%\update2.bat %Drv%\  /y
    call %Drv%\update2.bat
    call %drv%\tool\uptag.bat
    wait 1
    reboot.exe
goto End

REM ----------------------- End & Clear Temporary Data ---------------
:End
    cd %CD_Path%
    textmode.com
    if exist %drv%\out.bat del %drv%\out.bat
    set VerFile=
    set CD_Path=
    set TeCode=
    set Arg1=
    set Err=
    set Msg=
    set Act=
    set Get=
    set Info=
