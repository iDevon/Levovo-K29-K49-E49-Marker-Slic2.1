@echo off
REM ----------------------- Initial Arguments ------------------------
    set Ver=V003
    set Func=Dos_Write_SmbSer
    aset.exe BatchFile=locase(dir+'\%0')
    if @%SETLOG%==@1 call setlog.bat start "%BatchFile%" %Ver%

REM ----------------------- Main Program -----------------------------
  ::-- Get MTM
    inifile.com \@control.ini [SFCS] Sfcs_MTM >out.bat
    call out.bat

  ::-- Get Lenovo SN
    call getboxsn.bat
    aset.exe LeSn=left('%BoxSn%@',10)

  ::-- Check Lenovo SN
    aset.exe -n -e ans=len('@%leSn%') eq 10+1
if not errorlevel 1 goto LeSn_NG

  ::-- Check MTM
    set SmbSer=
    if @%Pn2%==@81 set SmbSer=1S%BoxSn%
    if @%Pn2%==@91 set SmbSer=1S%BoxSn%
    if @%Pn2%==@1S set SmbSer=%BoxSn%
    aset.exe -n -e ans=len('@%Sfcs_MTM%') eq 5+1
if errorlevel 1 set SmbSer=1S%Sfcs_MTM%  %LeSN%
    aset.exe -n -e ans=len('@%Sfcs_MTM%') eq 7+1
if errorlevel 1 set SmbSer=1S%Sfcs_MTM%%LeSN%
if @%SmbSer%==@ goto MTM_NG

  ::-- Check Smb Ser
    aset.exe -n -e ans=len('@%SmbSer%') eq 16+1
if @%Pn2%==@1S if not errorlevel 1 goto SmbSerNG
    aset.exe -n -e ans=len('@%SmbSer%') eq 18+1
if @%Pn2%==@81 if not errorlevel 1 goto SmbSerNG
if @%Pn2%==@91 if not errorlevel 1 goto SmbSerNG
    aset.exe -n -e ans=len('@%SmbSer%') eq 19+1
if not @%Pn2%==@1S if not @%Pn2%==@81 if not @%Pn2%==@91 if not errorlevel 1 goto SmbSerNG

  ::-- Write SmbSer
    serupdt d 20
    serupdt w 20 "%SmbSer%"

  ::-- Check SmbSer
    call getsmbs.bat
    aset.exe -n -e ans='%smbser@%' eq '%smbser%'
if errorlevel 1 goto End
goto WSmbS_NG

REM ----------------------- Fail Message -----------------------------
:LeSn_NG
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% GetLeSNNG
    call ng.bat LeSnLenNG
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto LeSn_NG

:MTM_NG
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% GetMtmNG
    call ng.bat MtmLenNG
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto MTM_NG

:SmbSerNG
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% SmbSerLenNG
    call ng.bat SmbSLenNG
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto SmbSerNG

:WSmbS_NG
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% W_SmbSer_NG
    call ng.bat WSMBSERNG
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto WSmbS_NG

REM ----------------------- End & Clear Temporary Data ---------------
:End
    if @%SETLOG%==@1 call setlog.bat end "%BatchFile%" %Ver% "%SmbSer%" "%SmbSer@%"
    if exist out.bat del out.bat
    set Ver=
    set Func=
    set BatchFile=
