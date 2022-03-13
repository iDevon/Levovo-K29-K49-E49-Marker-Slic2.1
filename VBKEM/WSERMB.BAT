@echo off

REM ------------------------- Initial Arguments ------------------------
 Set Func=DOS_Write_MB_SN
 aset.exe BatchFile=dir+'\%0'
 if @%SETLOG%==@1 call SETLOG.bat START

cls
clrkb.com
REM ------------------------- Main Program -----------------------------

:SCAN                                   
 message 15 "MB 11s"
 echo [15;13H[32mPlease Input MB SN(11S..........).[0m
 echo [21;13HLast Number:[1;31m %ser% [0m
 echo [11;09H
 GET S "           Enter Serial Number: " /u /vMBSer=
 play 8 1 3 5
 if @%MBSer%==@ goto SCAN
Goto CHECK

:CHECK
::-- A-Z 1-9 Check --::
 ck_ibmsr %MBSer%
 if errorlevel 1 goto IDNG

::-- Length check --::
 aset -n -e lenght=len('%MBSer%')==22
 if not errorlevel 1 goto IDNG

::-- Part number check --::
 aset serh=left('%MBSer%',3)
 if not @%serh%==@11S goto IDNG

:WRITE

    serupdt.exe d 40
    serupdt.exe w 40 %mbser%
 
:: -- Get from Machine
    serupdt r 40 | find /i "11S" | lmod.com /s set MB11S@=[$2] >out.bat
    call out.bat

 if not @%mbser%==@%mb11s@% goto MBSNNG
goto end

REM ------------------------- Fail Message -----------------------------
:IDNG
 message 12 "MB11S NG"
 echo [09;22H You give a Wrong PCB S/N !
 echo [11;22H Maybe 1.NG Barcode?
 echo [12;22H       2.NG Barcode scanner?
 echo [15;22H The Wrong S/N as: %MBSer%
 echo [22;25H[1;36mBatch File:%Batchfile% %1[0m
 play%ignoreNG% 9 9 9 15 11 0 0 0
 if errorlevel 1 goto end
clrkb.com
Goto SCAN
REM ----------------------- End & Clear Temporary Data ---------------
:END
cls
    echo mb11s: [1;32m%mb11s@%[0m

 if @%SETLOG%==@1 call SETLOG.bat END
 if exist out.bat del out.bat
 SET Func=
 SET Batchfile=
 SET ErrCode=
 SET SER=
 SET SERH=
 SET MBSN=
 SET MBSER=
