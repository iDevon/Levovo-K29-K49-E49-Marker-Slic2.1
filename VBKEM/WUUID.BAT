@echo off
REM ----------------------- Initial Arguments --------------------------
    set Ver=V001
    set Func=Dos_Boxuuid
    aset.exe BatchFile=locase(dir+'\%0')
    if @%SETLOG%==@1 call setlog.bat start "%BatchFile%" %Ver%

REM ----------------------- Main Program -------------------------------

:SCAN
cls
 message0 15 "scanuuid"
 echo [15;13H[32mPlease Input machine uuid(...,..........).[0m
 echo [21;13HLast Number:[1;31m %uuidser% [0m
 echo [11;09H
 GET S "           Enter Serial Number: " /u /vuuidser=
 play 8 1 3 5
 if @%uuidser%==@ goto SCAN

:Check
    ck_ibmsr %UUIDser%
if errorlevel 1 goto UUID_NG
    aset.exe -n -e len=len('@%UUIDser%') eq 32+1
if not errorlevel 1 goto UUID_NG
    aset.exe -n -e ans=pos('000000','%UUIDser%@')
if errorlevel 1 goto UUID_NG
    aset.exe -n -e ans=pos('FFFFFF','%UUIDser%@')
if errorlevel 1 goto UUID_NG


:SmbSN
    autouuid.exe xxx /d:00000000000000000000000000000000
    autouuid.exe xxx /d:%UUIDser%
    call getuuid.bat
 if not @%uuid%==@%uuidser% goto uuid_ng
goto end


:UUID_NG
message0 12 "FAIL"
pause
goto scan

REM ----------------------- End & Clear Temporary Data ---------------
:End
    if @%SETLOG%==@1 call setlog.bat end "%BatchFile%" %Ver% %uuid%
    set Ver=
    set Func=
    set BatchFile=
    set uuid@=


