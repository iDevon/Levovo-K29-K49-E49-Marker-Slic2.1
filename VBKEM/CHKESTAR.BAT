@echo off
REM ----------------------- Initial Arguments --------------------------
    set Ver=V004
    set Func=Dos_Chk_EStar
    aset.exe BatchFile=locase(dir+'\%0')
    if @%SETLOG%==@1 call setlog.bat start "%BatchFile%" %Ver%

REM ----------------------- Main Program -------------------------------
  ::-- Get Preload from SFCS
    inifile.com \@control.ini [SFCS] Sfcs_Image_PN>out.bat
    call out.bat
if @%Sfcs_Image_PN%==@ goto NImagePn

  ::-- Get PN2
    call \func\nvs\getboxsn.bat

  ::-- Default EStar is ON
    set EpaFlag=ON

   ::-- DOS & Linux Preload EStar is Off
    echo @%Sfcs_Image_Pn% | find /i "534EL11011" >nul
    if not errorlevel 1 set EpaFlag=OFF
    echo @%Sfcs_Image_Pn% | find /i "534EL11001" >nul
    if not errorlevel 1 set EpaFlag=OFF
    echo @%Sfcs_Image_Pn% | find /i "534MN06001" >nul
    if not errorlevel 1 set EpaFlag=OFF
    echo @%Sfcs_Image_Pn% | find /i "534MN06002" >nul
    if not errorlevel 1 set EpaFlag=OFF
    echo @%Sfcs_Image_Pn% | find /i "189501270"> nul
    if not errorlevel 1 set EpaFlag=OFF
    echo @%Sfcs_Image_Pn% | find /i "189501142" >nul
    if not errorlevel 1 set EpaFlag=OFF
    echo @%Sfcs_Image_Pn% | find /i "FFFFFFFFF" >nul
    if not errorlevel 1 set EpaFlag=OFF
    echo @%Sfcs_Image_Pn% | find /i "189501271" >nul
    if not errorlevel 1 set EpaFlag=OFF
    echo @%Sfcs_Image_Pn% | find /i "189500778" >nul
    if not errorlevel 1 set EpaFlag=OFF
    echo @%Sfcs_Image_Pn% | find /i "189501143" >nul
    if not errorlevel 1 set EpaFlag=OFF
    echo @%Sfcs_Image_Pn% | find /i "000000B62415" >nul
    if not errorlevel 1 set EpaFlag=OFF
    echo @%Sfcs_Image_Pn% | find /i "000000B62417" >nul
    if not errorlevel 1 set EpaFlag=OFF
    echo @%Sfcs_Image_Pn% | find /i "000000B62419" >nul
    if not errorlevel 1 set EpaFlag=OFF

  ::-- P/R EStar is ON
    if @%PN2%==@81 set EpaFlag=ON
    if @%PN2%==@91 set EpaFlag=ON
    if @%PN2%==@1S set EpaFlag=OFF
    if @%NBTpyte%==@SHELL SET EpaFlag=OFF
    
  ::-- Get SFCS EPA Flag
    inifile.com \@control.ini [SFCS] Sfcs_Energy>out.bat
    call out.bat
if @%Sfcs_Energy%==@ goto NEnergy
    if not @%Sfcs_Energy%==@NA set SfcsEpaFlag=ON
    if     @%Sfcs_Energy%==@NA set SfcsEpaFlag=OFF
if     @%EpaFlag%==@ goto NEpaflag
if not @%PN2%==@81 if not @%PN2%==@91 if not @%EpaFlag%==@%SfcsEpaFlag% goto EpaNG

  ::-- Check EPA Flag
    call getestar.bat
if not @%EpaFlag%==@%EpaFlag@% goto Epa_NG
goto End

REM ----------------------- Fail Message -----------------------------
:NImagePn
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% NoImagePn
    call ng.bat NoImagePn
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto NImagePn

:NEnergy
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% NoEnergy
    call ng.bat NoEnergy
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto NEnergy

:NEpaFlag
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% No_Epa_Flag
    call ng.bat NoEpaFlag
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto NEpaFlag

:Epa_NG
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% Chk_EpaFlag_NG "%SfcsEpaFlag%" "%EpaFlag@%"
    call ng.bat CEPANG
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto Epa_NG

:EpaNG
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% Sfcs_EPA %EpaFlag% %SfcsEpaflag%
    call ng.bat SFCSEPANG
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto EpaNG

REM ----------------------- End & Clear Temporary Data ---------------
:End
    if @%SETLOG%==@1 call setlog.bat end "%BatchFile%" %Ver% "%EpaFlag%" "%EpaFlag@%"
    set Func=
    set Ver=
    set BatchFile=
    set EpaFlag=
    set EpaFlag@=
