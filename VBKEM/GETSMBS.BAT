@echo off
REM ------------------------- Main Program -----------------------------
    serupdt r 20 | lmod /l3 set SmbSer@=[6] >out.bat
    call out.bat

    aset.exe Mtm@=copy('%SmbSer@%@',3,7)
    aset.exe LeSn@=right('@%SmbSer@%',10)

    echo %SmbSer@% | find /i "Data not found." >nul
    if not errorlevel 1 set SmbSer@=
    if not errorlevel 1 set Mtm@=
    if not errorlevel 1 set LeSn@=

REM ----------------------- End & Clear Temporary Data -----------------
    if exist out.bat del out.bat
    inifile.com \@control.ini [ID] SmbSer@=%SmbSer@%
    inifile.com \@control.ini [ID] Mtm@=%Mtm@%
    inifile.com \@control.ini [ID] LeSn@=%LeSN@%
    echo SmbSer: [1;32m%SmbSer@%[0m
