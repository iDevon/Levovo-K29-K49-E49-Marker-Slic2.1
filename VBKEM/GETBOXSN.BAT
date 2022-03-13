@echo off
REM ------------------------- Main Program -----------------------------
  ::-- Check Model
   call getmbmdl.bat
  
  inifile \func\nvs\serial.ini [%Model%] NvsType>out.bat
    call out.bat
if not @%NvsType%==@ goto %NvsType%
    inifile \func\nvs\serial.ini [%MbModel@%] NvsType>out.bat
    call out.bat
if not @%NvsType%==@ goto %NvsType%
goto NoModel

:SmbSN
    smbsn /rsn | find /i "Serail Number" | lmod.com /s set BoxSN=[$3] >out.bat
    call out.bat
goto Next

:MBD
    mbd.exe /Rs 40 20 | Lmod set BoxSn=[] >out.bat
    call out.bat
goto Next

:Next
    aset.exe Pn2=left('%Boxsn%@',2)
    aset.exe Ph@=left('%Boxsn%@',3)
    aset.exe PN5=copy('%Boxsn%@',2,5)

goto End

REM ----------------------- Fail Message -------------------------------
:NoModel
    if @%SETLOG%==@1 call setlog.bat fail "%BatchFile%" %Ver% AddNvsType
    call ng.bat ADDNVSTYPE
    play%IGNORENG%.exe 15 11 0 15 11 0 
if errorlevel 1 goto end
goto NoModel

REM ----------------------- End & Clear Temporary Data -----------------
:End
    if exist out.bat del out.bat
    inifile.com \@control.ini [ID] BoxSN=%BoxSN%
    inifile.com \@control.ini [ID] PN2=%PN2%
    inifile.com \@control.ini [ID] Ph@=%Ph@%
    inifile.com \@control.ini [ID] PN5=%PN5%

    echo BoxSN: [1;32m%BoxSN%[0m
    echo [1A
