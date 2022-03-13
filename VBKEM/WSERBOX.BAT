@echo off
REM ------------------------- Initial Arguments ------------------------
 Set Func=DOS_Write_MB_SN
 aset.exe BatchFile=dir+'\%0'

REM ------------------------- Main Program -----------------------------
:start
cls
clrkb.com

:SCANMTM
 message 15 "scan MTM"

 echo [15;13H[32mPlease Input machine MTM(5bits or 7bits..........).[0m

 echo [16;13H [33mfor example:20178(5bits) or 34465RZ(7bits) [0m
                                        
 echo [21;13HLast Number:[1;31m %ser% [0m
 echo [11;09H
 GET S "           Enter Machine MTM: " /u /vMTMser=
 play 8 1 3 5
 if @%MTMSer%==@ goto SCANMTM


:CHECKMTM
::-- A-Z 1-9 Check --::
 ck_ibmsr %MTMSer%
 if errorlevel 1 goto IDNG

::-- Length check --::
:lenth1
 aset MTMLEN=len('%MTMSer%')

 aset -n -e MTMLEN1=len('%MTMSer%')==5
 if errorlevel 1 goto scanser

:lenth2
 aset -n -e MTMLEN1=len('%MTMSer%')==7
 if errorlevel 1 goto scanser

goto IDNG

:SCANSER
CLS
 message 14 "scan SER"

 echo [15;13H[32mPlease Input machine Serial Number(7bits or 10bits..........).[0m
 echo [16;13H [33mfor example:R9HM45L(7bits) or WB01234567(10bits) [0m
                                                                        
 echo [21;13HLast Number:[1;31m %ser% [0m
 echo [11;09H
 GET S "           Enter Machine serial Number: " /u /vsser=
 play 8 1 3 5
 if @%sSer%==@ goto SCANser


:CHECKSER
::-- A-Z 1-9 Check --::
 ck_ibmsr %sSer%
 if errorlevel 1 goto IDNG

::-- Length check --::

 aset serLEN=len('%sser%')

:lenth1
 aset -n -e SERLEN1=len('%sSer%')==7
 if errorlevel 1 goto write
:lenth2
 aset -n -e SERLRN1=len('%sSer%')==10
 if errorlevel 1 goto write
goto IDNG

  ::-- Write SmbSer
:write
                                        
::  if @%mtmlen%==@5 if not @%serlen%==@10  goto IDNG
::  if @%mtmlen%==@7 if not @%serlen%==@7 goto IDNG

::  aset Sserh=left('%SSer%',3)
::  if @%serlen%==@10 if not @%sserh%==@WB0 goto IDNG
                                                

  if @%mtmlen%==@5 set smbser=1S%mtmser%  %sser%
  if @%mtmlen%==@7 set smbser=1S%mtmser%%sser%


    serupdt d 20
    serupdt w 20 "%SmbSer%"

    serupdt r 20 | lmod /l3 set SmbSer@=[6] >out.bat
    call out.bat

    aset.exe -n -e ans='%smbser@%' eq '%smbser%'
if errorlevel 1 goto End

REM ----------------------- Fail Message -----------------------------
:IDNG
    cls
    echo [2;0H[1;31m
    textecho.exe -s -lightred "´íÎóĞòÁĞºÅ"
    locate.com 12 28
    vtmagic.com /P Ë¢´íµÄÌõÂëÊÇ: %S%[0m
    play.exe 9 15 11 0 0 0
goto start

REM ----------------------- End & Clear Temporary Data ---------------
:End
cls
    echo BoxSN: [1;32m%smbser%[0m

    if exist out.bat del out.bat
    set Func=
    set Ver=
    set BatchFile=
    set Ser1=
    set Ser2=
    set S=
    set SerHead@=
    set SerLength=
