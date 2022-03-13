@echo off
REM ----------------------- Main Program -----------------------------
::::-- Check the RTC time not reset
aset -e year=year(date) ge 2007
if not errorlevel 1 goto RTC_RSET

:::: --Check_RTC_time stop or not
rtime > time1.log
play 1 2
play 3 4
wait.exe 1
play 5 6
play 7 8
rtime > time2.log
fc time1.log time2.log>def.txt
find "FC: no differences encountered" def.txt>nul
if not errorlevel 1 goto again
goto RTC_GO

:::: --To avoid press any key to make mistake
:again
play 1 2
play 3 4
wait.exe 1
play 5 6
play 7 8
rtime > time2.log
fc time1.log time2.log>def.txt
find "FC: no differences encountered" def.txt>nul
if not errorlevel 1 goto RTC_STOP
:RTC_GO

:::: --Check RTC time is the same as system time
RTIME>CMOST.TXT
GT>nul
call out.bat
find /I "%HH%:%MIN%" CMOST.TXT
if errorlevel 1 goto RETRY
goto RTC_CT

:RETRY
play 1 2 3 4 5 6 7 8
RTIME>CMOST.TXT
GT>nul
call out.bat
find /I "%HH%:%MIN%" CMOST.TXT
if errorlevel 1 goto RTC_DIF
:RTC_CT


:time_now
aset datenow=date
aset timenow=time
aset minnow=((YEAR()*365+DOY())*24+HOUR())*60+MINUTE()
aset minpass=%minnow%-%minold%

:check
::-- Check the error value lower than 10 minutes between system time with server time
::-- [retrun test machine's expection value]
::--    Thinkpad  = +60
::--    Gama      = -420
::--    Benz	  = -480
aset -n -e ans=abs(%minpass%    ) gt 10
if not errorlevel 1 goto end
goto Time_NG

REM ----------------------- Fail Message -----------------------------
:Time_NG
logecho 20$Y-$M-$D $h:$m:$s %PARTNO% %mac% time NG, error time:%olddate% %oldtime% >> G:\LOG\%YY%%MM%%DD%.txt
:::: ---Only record one time
:Time_NG1
message0 12 "TIME NG"
echo [10;14H[1;35m Machine time mustn't over 10 minites after log on server.  [0m
echo [12;14H[1;32m Time before log on server : %olddate% %oldtime%[0m
echo [14;14H[1;31m Time after log on server : %datenow% %timenow%[0m
echo [16;14H[1;33m Please press any key to find PE/TE name.[0m
echo [21;25H[1;36mBatch File: \tools\ChkRTime.bat[0m
date %olddate%
time %oldtime%
pause>nul
cls
cd\tools
showjpg PETENAME.jpg
goto Time_NG1

:RTC_RSET
logecho 20$Y-$M-$D $h:$m:$s %PARTNO% %mac% RTC Reset, error time:%olddate% %oldtime% >> M:\LOG\%YY%%MM%%DD%.txt
:::: ---Only record one time
:RTC_RSET1
message0 12 "RTC Rset"
echo [10;14H[1;35m RTC(CMOS) time NG  [0m
echo [12;14H[1;32m Maybe the RTC time reset[0m
echo [14;14H[1;31m The error time is : %olddate% %oldtime%[0m
echo [16;14H[1;33m Please press any key to find PE/TE name.[0m
echo [21;25H[1;36mBatch File: \tools\ChkRTime.bat[0m
pause>nul
cls
cd\tools
showjpg PETENAME.jpg
goto RTC_RSET1

:RTC_STOP
logecho 20$Y-$M-$D $h:$m:$s %PARTNO% %mac% RTC Stop, error time:%olddate% %oldtime% >> M:\LOG\%YY%%MM%%DD%.txt
:::: ---Only record one time
:RTC_STOP1
message0 12 "RTC STOP"
echo [10;14H[1;35m RTC(CMOS) time NG  [0m
echo [12;14H[1;32m Maybe the RTC time Stop[0m
echo [14;14H[1;31m The error time is : %olddate% %oldtime%[0m
echo [16;14H[1;33m Please press any key to find PE/TE name.[0m
echo [21;25H[1;36mBatch File: \tools\ChkRTime.bat[0m
pause>nul
cls
cd\tools
showjpg PETENAME.jpg
goto RTC_STOP1

:RTC_DIF
logecho 20$Y-$M-$D $h:$m:$s %PARTNO% %mac% RTC difference, error time:%olddate% %oldtime% >> M:\LOG\%YY%%MM%%DD%.txt
:::: ---Only record one time
:RTC_DIF1
message0 12 " RTC DIF"
echo [10;14H[1;35m RTC(CMOS) time NG  [0m
echo [12;14H[1;32m Maybe the RTC time is not the same as system time[0m
echo [14;14H[1;31m The error time is : %olddate% %oldtime%[0m
echo [16;14H[1;33m Please press any key to find PE/TE name.[0m
echo [21;25H[1;36mBatch File: \tools\ChkRTime.bat[0m
pause>nul
cls
cd\tools
showjpg PETENAME.jpg
goto RTC_DIF1


REM ----------------------- End & Clear Temporary Data ---------------
:end
set olddate=
set oldtime=
set minold=
set datenow=
set timenow=
set minnow=
set minpass=

