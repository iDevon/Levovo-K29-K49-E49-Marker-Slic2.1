@echo off
REM ----------------------- Initial Arguments --------------------------
    set Ver=V002
    set Func=Dos_Clear_NVS
    aset.exe BatchFile=locase(dir+'\%0')
    if @%SETLOG%==@1 call setlog.bat start "%BatchFile%" %Ver%

REM ----------------------- Main Program -------------------------------
    cls
    echo [2;0H
    textecho -s -brightwhite "Çå¿ÕNVS"

  ::-- Check Model
    inifile \func\nvs\serial.ini [%Model%] NvsType>out.bat
    call out.bat
if not @%NvsType%==@ goto %NvsType%
    inifile \func\nvs\serial.ini [%MbModel@%] NvsType>out.bat
    call out.bat
if not @%NvsType%==@ goto %NvsType%
goto NoModel

:SmbSN
    eep_init.com
    call biosdef.bat
goto End

:MBD
    mbd /Wf nvs.clr
goto End

REM ----------------------- Fail Message -------------------------------
:NoModel
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% AddNvsType
    call ng.bat ADDNVSTYPE
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto NoModel

REM ----------------------- End & Clear Temporary Data ---------------
:End
    if @%SETLOG%==@1 call setlog.bat end "%BatchFile%" %Ver% %NVSType%
    set Ver=
    set Func=
    set BatchFile=
