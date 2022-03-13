cls

call model.bat

cls

bigtext /fs /ss "%model@%"


echo 1.Write MB 11S-(Only For K49/E49/K29)
echo 2.Write Machine SSN
echo 3.Write UUID Manul
echo 4.Write UUID AUTO
echo 5.Slp2 Enable
echo 6.Slp2 Disable
echo 7.Clear EEPROM(clear all SN)
echo 8.Exit
echo Any Question Please Email: QIUML@LENOVO.COM

choice /c:12345678
if errorlevel 1 if not errorlevel 2 goto MB11s
if errorlevel 2 if not errorlevel 3 goto ssn
if errorlevel 3 if not errorlevel 4 goto uuid
if errorlevel 4 if not errorlevel 5 goto autouuid
if errorlevel 5 if not errorlevel 6 goto slp2_en
if errorlevel 6 if not errorlevel 7 goto slp2_dis
if errorlevel 7 if not errorlevel 8 goto eepclr
if errorlevel 8 if not errorlevel 9 goto exit
                                                

:mb11S
 call wsermb.bat
goto end
                                                
:SSN
 call wserbox.bat
goto end

:UUID
 call wuuid.bat
goto end

:autouuid
 call setuuid.bat
goto end

:slp2_en
if     @%slp2@%==@NOBIN call s1.bat EN
if not @%slp2@%==@NOBIN call s2.bat EN
goto end

:slp2_dis
 if     @%slp2@%==@NOBIN call s1.bat DIS
 if not @%slp2@%==@NOBIN call s2.bat DIS
goto end


:eepclr
cls
 bigtext /fs /ss " Notice"
 echo [16;20H [1;31m All SN will be cleard[0m
 echo [18;20H [1;34m Do you continue?[0m
choice /c:YN
if errorlevel 1 if not errorlevel 2 goto eep_smb
goto end

:eep_smb
if @%PartNo@%==@4UG01 goto eep_rfid
if @%PartNo@%==@4UH01 goto eep_rfid

cls
eep_init.com
vrfid /wsw 5 7e aa55
if errorlevel 1 goto ClrFail
goto end


:eep_rfid
    rfid /Rsh ac ff 1 | find /i "55" >nul
if not errorlevel 1 goto SmbCRfid
    rfid /Rsh ac ff 1 | find /i "FF" >nul
if not errorlevel 1 rfid /Rsh a8 08 1 | find /i "FF">nul
if not errorlevel 1 goto SmbCRfid
    rfid /Wsh ac fe a155

 echo [20;20H [1;31m System need reboot[0m
    pause 
    reboot

:SmbCRfid 
    eep_init.com
if errorlevel 1 goto ClrFail
goto End
:clrfail
 message0 12 "FAIL"
 echo [16;20H [1;31m System need reboot[0m
pause
reboot

:end
message0 13 "OK"
pause
a.bat

:exit
message0 13 "OK"
pause
ichs5
