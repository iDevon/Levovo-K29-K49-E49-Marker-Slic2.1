Echo off  

call model.bat

::---------normal bin-------::
if exist TP-%BIOSH2%_7.BIN goto start

::---------special bin-------::

goto nobin

:start

cls
 bigtext /fs /ss "   SLP2  "
 wait.com 1
cls
 bigtext /fs /ss " %model@% "
 echo [15;20H [1;31m 1.SLP2 Enable[0m
 echo [16;20H [1;31m 1.SLP2 Disable[0m
 echo [17;20H [1;31m 1.SLP2 Exit[0m
choice /c:123   >nul
if errorlevel 1 if not errorlevel 2 goto SLP2EN
if errorlevel 2 if not errorlevel 3 goto SLP2DIS
 goto end
:slp2EN
 call s2.bat EN

:SLp2DIS
 call s2.bat DIS

goto end

:NOBIN
 cls
 bigtext /fs /ss "NO BIN"
 pause>nul
 goto nobin
:end
message0 13 "OK"
pause
s.bat

:exit
message0 13 "OK"
pause
ichs5
