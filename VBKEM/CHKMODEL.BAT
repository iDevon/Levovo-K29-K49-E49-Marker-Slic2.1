@echo off
set MODEL=UNKNOW

int15@ 2310 0000 0000 0000 AL>out.bat
call out.bat
if @%AX%==@99 set MODEL=JNOTE
if @%AX%==@9f set MODEL=JNOTE
if @%AX%==@9d set MODEL=S3A
if @%AX%==@9e set MODEL=S3A
if @%AX%==@95 set MODEL=KNOTE
if @%AX%==@93 set MODEL=SNOTE
if @%AX%==@98 set MODEL=SNOTE
if @%AX%==@a2 set MODEL=KNOTE6
if @%AX%==@a5 set MODEL=KSNOTE
if @%AX%==@a6 set MODEL=RPNOTE
if @%AX%==@a7 set MODEL=RPNOTE
if @%AX%==@a8 set MODEL=RPNOTE
if @%AX%==@ad set MODEL=DALI
if @%AX%==@b2 set MODEL=KS3
if @%AX%==@b6 set MODEL=DALI2
if @%AX%==@b5 set MODEL=RP4
if @%AX%==@b9 set MODEL=MP1
if @%AX%==@bb set MODEL=LNC
if @%AX%==@bc set MODEL=LCM

int15@ 9604 f700 0000 0000 cx>out.bat
call out.bat
if @%CX%==@4246 if @%DX%==@425a goto ME
if @%CX%==@3946 set MODEL=Fnote
if @%CX%==@4235 set MODEL=FNOTE2
if @%CX%==@4236 set MODEL=ANOTE
if @%CX%==@4337 set MODEL=FNOTE2
if @%CX%==@4338 set MODEL=QILIAN
if @%CX%==@4344 set MODEL=LT71
if @%CX%==@4246 set MODEL=C45
if @%CX%==@4133 set MODEL=X40
if @%CX%==@3742 set MODEL=Y40
if @%CX%==@4141 set MODEL=Y4B
if @%CX%==@4335 set MODEL=LV
if @%CX%==@4130 set MODEL=LWG10
if @%CX%==@4144 goto LWG
if @%CX%==@4231 goto LWG
if %MODEL%==UNKNOW goto model_ng
goto partno

:LWG
f44 \tools\LWG2.f01 ##Model?
if     errorlevel 1 set MODEL=LWG11
if not errorlevel 1 set MODEL=LWG2
goto partno

:ME
f44 \TOOLS\ME2.F03 ##MODEL?
if     errorlevel 1 set MODEL=ME2
if not errorlevel 1 set MODEL=ME3
goto partno

:partno
set partno=UNKNOW

if @%MODEL%==@RPNOTE set partno=4E601
if @%MODEL%==@RP4    set partno=4T401
if @%MODEL%==@KSNOTE set partno=4B501
if @%MODEL%==@JNOTE  set partno=48N01
if @%MODEL%==@S3A    set partno=45X01
if @%MODEL%==@SNOTE  set partno=49U01
if @%MODEL%==@DALI   set partno=4Q401
if @%MODEL%==@KNOTE6 set partno=4C101
if @%MODEL%==@KNOTE  set partno=48D01
if @%MODEL%==@KS3    set partno=4B401
if @%MODEL%==@DALI2  set partno=4T801
if @%MODEL%==@MP1    set partno=47Q01
if @%MODEL%==@LNC    set partno=4Y901
if @%MODEL%==@LCM    set partno=4Y401

if @%MODEL%==@C45    set partno=4U501
if @%MODEL%==@X40    set partno=4P301
if @%MODEL%==@Y40    set partno=4P501
if @%MODEL%==@Y4B    set partno=4B901
if @%MODEL%==@LV     set partno=4V701
if @%MODEL%==@LWG10  set partno=4F901
if @%MODEL%==@LWG11  set partno=4F902
if @%MODEL%==@LWG2   set partno=4Q801
if @%MODEL%==@Fnote  set partno=4F801
if @%MODEL%==@FNOTE2 set partno=4S801
if @%MODEL%==@ANOTE  set partno=4T001
if @%MODEL%==@YULONG set partno=4S801
if @%MODEL%==@QILIAN set partno=4T501
if @%MODEL%==@LT71   set partno=4X001
if @%MODEL%==@ME2    set partno=4X601
if @%MODEL%==@ME3    set partno=4W601
if @%partno%==@UNKNOW goto model_ng
goto end

:model_ng
message 12 "MODEL NG"
echo [10;18H[1;33mMake Sure This Test Program IS For This Model...[0m
echo [21;25H Press Power Key To Shutdown...
echo [13;25H Model Name   = [1;32m%model% [0m
echo [15;25H         AX   = [1;32m%ax%    [0m
echo [16;25H         cX   = [1;32m%cx%    [0m
play 45 1 0 0 0 0 0 0 0 0 0 0 45 1 
pause>nul
goto model_ng

:end
set AX=
set BX=
set CX=
set DX=

if exist out.bat del out.bat
