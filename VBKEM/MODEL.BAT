@echo off
REM ----------------------- Main Program -------------------------------
    set ModelID@=Unknown ModelID
    set Model@=Unknown Model


  ::-- Thinkpad
    int15@.exe 2310 0000 0000 0000 CY>out.bat
if errorlevel 1 goto Lenovo
    call out.bat
    set ModelID@=%ax%
if @%ModelID@%==@d2 goto Lenovo
if not @%ModelID@%==@d4 goto GetModel

    int15@.exe 9604 F700 0000 0000 CY>out.bat
    call out.bat
if @%ModelID@%==@d4 if @%dx%==@3141 set ModelID@=%cx%%dx%
goto GetModel

:Lenovo
    int15@.exe 9604 F700 0000 0000 CY>out.bat
if errorlevel 1 goto Model_NG
    call out.bat
    set ModelID@=%cx%%dx%
goto GetModel

:GetModel
    inifile.com model.ini [%ModelID@%%1] >out.bat
    call out.bat
goto End

REM ----------------------- Fail Message -----------------------------
:Model_NG
message0 13 "MOdel_NG"
Pause
goto Model_NG

REM ----------------------- End & Clear Temporary Data ---------------
:End
    echo Model: [1;32m%Model@% %PartNo@%[0m
    if exist out.bat del out.bat
    set AX=
    set BX=
    set CX=
    set DX=

