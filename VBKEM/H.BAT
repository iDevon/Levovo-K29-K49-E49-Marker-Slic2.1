@echo off
REM ------------------------- Main Program -----------------------------
:start
cls
clrkb.com

:SCANh2
 message 15 " BIOS "
                                        
 echo [15;13H[32mPlease Input the left 2 number of bios.[0m

 echo [16;13H [33mfor example:if BIOS is H1ET30WW,please input "H1"[0m
 echo [17;13H [35m            if BIOS is HKET30WW,please input "HK"[0m
                                        
 echo [21;13HLast Number:[1;31m %H2% [0m
 echo [11;09H
 GET S "           Enter BIOS left 2 number: " /u /vH2=
 play 8 1 3 5
 if @%H2%==@ goto SCANh2

::-- A-Z 1-9 Check --::
 ck_ibmsr %h2%
 if errorlevel 1 goto scanh2

::-- Length check --::

 aset -n -e h2LEN1=len('%h2%')==2
 if not errorlevel 1 goto scanh2

if @%h2%==@52 set model=B475
if @%h2%==@HG set model=B475

if @%h2%==@H1 set model=V480S
if @%h2%==@H2 set model=KE
if @%h2%==@H3 set model=VB4858
if @%h2%==@H5 set model=VB4858
if @%h2%==@H9 set model=B475
if @%h2%==@HJ set model=M495
if @%h2%==@HK set model=LPRAMD

if not @%model%==@B475 if not exist TP-%h2%_7.bin goto nobin


cls
 bigtext /fs /ss " %model%"
 echo [16;20H [1;31m 1.SLP2 Enable[0m
 echo [18;20H [1;34m 2.SLP2 Disable[0m
choice /c:12
if errorlevel 1 if not errorlevel 2 goto SLP2EN
if errorlevel 2 if not errorlevel 3 goto SLP2DIS

:slp2EN
if not @%model%==@B475 call s22.bat EN
if    @%model%==@B475  call  s1.bat EN

goto end

:SLp2DIS
 if NOT @%model%==@B475 call s22.bat DIS
 if     @%model%==@B475 call s1.bat DIS

goto end

:nobin
message0 13 "no bin"

 echo [17;13H [35m there is no bin file for this model[0m
 pause
goto  start
                                                                        
:end
message0 13 "OK"
pause
H.bat

:exit
message0 13 "OK"
pause
ichs5

