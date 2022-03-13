@echo off
REM ------------------------- Main Program -----------------------------
  ::-- Check Model
    if @%MbModel@%==@ call \func\equ\getmbmdl.bat
    inifile \func\nvs\serial.ini [%MbModel@%] NvsType>out.bat
    call out.bat
if not @%NvsType%==@ goto %NvsType%
    inifile \func\nvs\serial.ini [%Model%] NvsType>out.bat
    call out.bat
if not @%NvsType%==@ goto %NvsType%
goto NoModel

:SmbSN
    vrfid.exe /rsb 8 11 | lmod.com /l5 set EpaFlag@=[30,2]>out.bat
    call out.bat
    if @%EpaFlag@%==@00 set EpaFlag@=OFF
    if @%EpaFlag@%==@FF set EpaFlag@=OFF
    if @%EpaFlag@%==@01 set EpaFlag@=ON
goto End

:MBD
    mbd.exe /Rh 2E 01 | lmod set EpaFlag@=[]>out.bat
    call out.bat
    if @%EpaFlag@%==@00 set EpaFlag@=ON
    if @%EpaFlag@%==@AA set EpaFlag@=OFF  
goto End

:SmbRfid
   vestar status | find /i "Enable Energy ON">nul
if not errorlevel 1 set EpaFlag@=ON
if     errorlevel 1 set EpaFlag@=OFF
goto End

REM ----------------------- Fail Message -------------------------------
:NoModel
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% AddNvsType
    call ng.bat ADDNVSTYPE
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto NoModel

REM ----------------------- End & Clear Temporary Data -----------------
:End
    if exist out.bat del out.bat
    inifile.com \@control.ini [ID] EpaFlag@=%EpaFlag@%
    echo EPA Flag: [1;32m%EpaFlag@%[0m
