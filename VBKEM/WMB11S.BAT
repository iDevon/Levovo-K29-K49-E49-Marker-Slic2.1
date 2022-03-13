::===================== File Header ==========================================
:: Description: Check M/B 11S with SFCS(Scaned in assembly)
::
::===================== Requriment(s) ========================================
:: Golbal Variable: 
::
::===================== Modified Histroy======================================
:: 2010-06-27 V1.0 Joe C Qiao - First Release
::===================== Modified Histroy======================================

@ECHO OFF
REM ----------------------- Initial Arguments ------------------------
 Set Func=DOS_MB11S_Check
 Aset.exe BatchFile=dir+'\%0'
 if @%setlog%==@1 call setlog.bat start

:: -- Get 11s SFCS AAA
 if @%mac8%==@ inifile %drv%\@Control.ini [ID] mac8 >%drv%\out.bat
 if @%mac8%==@ call %drv%\out.bat

 inifile %drv%\%mac8%.aaa [SFC] mb11s>%drv%\out.bat
 call %drv%\out.bat
 if @%mb11s%==@NA goto MBSNNG
 if @%mb11s%==@   goto MBSNNG

    serupdt.exe d 40
    serupdt.exe w 40 %MB11S%

:: -- Get from Machine
    serupdt r 40 | find /i "11S" | lmod.com /s set MB11S@=[$2] >out.bat
    call out.bat

 if not @%mb11s%==@%mb11s@% goto MBSNNG
goto end

REM ----------------------- Fail Message -----------------------------
:MBSNNG
  inifile.com %DRV%\%mac8%.aaa [SFC] SFCS55L>%DRV%\out.bat
  call %DRV%\out.bat
  del out.bat
  call SaveLog.bat 11SNG %mb11s@% %mb11s% %SFCS55L%  
  
:showng
call Ng.bat MBSN_NG 
pause
goto showng

 pause>nul
goto MBSNNG

REM ----------------------- End & Clear Temporary Data ---------------
:end
 if @%setlog%==@1 call setlog.bat end
 if exist out.bat del out.bat
 Set Func=
 Set BatchFile=
 Set mb11s=
 Set mb11s@=


