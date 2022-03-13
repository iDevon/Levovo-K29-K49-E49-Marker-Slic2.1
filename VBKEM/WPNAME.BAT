
@echo off
REM ----------------------- Initial Arguments --------------------------
    set Ver=V002
    set Func=Dos_ProductName
    aset.exe BatchFile=locase(dir+'\%0')
    if @%SETLOG%==@1 call setlog.bat start "%BatchFile%" %Ver%

REM ----------------------- Main Program -------------------------------
  ::-- Get MB Model from SFCS
    if @%MbModel@%==@ call \func\equ\getmbmdl.bat
if @%MbModel@%==@ goto NoModel
    if @%pn5%==@ call \func\nvs\getboxsn.bat
if @%pn5%==@ goto NoModel

  ::-- Get Product Name
    inifile \func\nvs\serial.ini [%Model%] ProdName>out.bat
    call out.bat
if not @%ProdName%==@ goto Next
    inifile \func\nvs\serial.ini [%MbModel@%] ProdName>out.bat
    call out.bat
if not @%ProdName%==@ goto Next
goto NoPName

:Next
    inifile \func\nvs\serial.ini [%Model%] NvsType>out.bat
    call out.bat
if not @%NvsType%==@ goto %NvsType%
    inifile \func\nvs\serial.ini [%MbModel@%] NvsType>out.bat
    call out.bat
if not @%NvsType%==@ goto %NvsType%
goto NoModel

:SmbSN
if @%pn5%==@14TK0 SET ProdName=Zhaoyang E49
if @%pn5%==@14TKZ SET ProdName=Zhaoyang E49
if @%pn5%==@S914W SET ProdName=Lenovo E49
   
 cfgupdt.exe w /brandname="%ProdName%"
goto Check

:MBD
    mbd.exe /Wh 60 00000000000000000000000000000000
    mbd.exe /Wh 70 00000000000000000000000000000000
    mbd.exe /Ws 60 "%ProdName"
    mbd.exe /CHK 60 20
goto Check

:Check
    call getpname.bat
    aset -n -e ans='@%ProdName%' eq '@%ProdName@%'
if not errorlevel 1 goto Fail
goto End

REM ----------------------- Fail Message -----------------------------
:Fail
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% Write_PrdName_NG "%ProdName%" "%ProdName@%"
    call ng.bat WPRDNAMENG
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto Fail

:NoModel
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% No_MBModel@
    call ng.bat NMBMODEL@
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto NoModel

:NoPName
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% No_PrdName
    call ng.bat NOPRDNAME
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto NoPName

REM ----------------------- End & Clear Temporary Data ---------------
:End
    if @%SETLOG%==@1 call setlog.bat end "%BatchFile%" %Ver% "%ProdName%" "%ProdName@%"
    if exist out.bat del out.bat
    set Func=
    set Ver=
    set BatchFile=
    set ProdName=
    set ProdName@=
