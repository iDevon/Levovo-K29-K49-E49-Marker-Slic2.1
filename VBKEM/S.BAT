Echo off  

cls

bigtext /fs /ss "  SLP2"
locate 10 20
echo [10;20H [1;32m 1.V480s[0m
echo [11;20H [1;31m 2.V480/V580/B480/B580[0m
echo [12;20H [1;33m 3.K49/E49/K29[0m
echo [13;20H [1;34m 4.B575/B475/B475E/B575E[0m
echo [14;20H [1;31m 5.M490[0m
echo [15;20H [1;33m 6.M495[0m
echo [16;20H [1;36m 7.exit[0m

choice /c:1234567
if errorlevel 1 if not errorlevel 2 set model=V480S 
if errorlevel 2 if not errorlevel 3 set model=VB4858
if errorlevel 3 if not errorlevel 4 set model=KE
if errorlevel 4 if not errorlevel 5 set model=B475
if errorlevel 5 if not errorlevel 6 set model=M490
if errorlevel 6 if not errorlevel 7 set model=M495
if errorlevel 7 if not errorlevel 8 goto exit 
                                                
cls
 bigtext /fs /ss " %model%"
 echo [16;20H [1;31m 1.SLP2 Enable[0m
 echo [18;20H [1;34m 2.SLP2 Disable[0m
choice /c:12
if errorlevel 1 if not errorlevel 2 goto SLP2EN
if errorlevel 2 if not errorlevel 3 goto SLP2DIS

:slp2EN
if not @%model%==@B475 call s2.bat EN
if    @%model%==@B475  call  s1.bat EN

goto end

:SLp2DIS
 if NOT @%model%==@B475 call s2.bat DIS
 if     @%model%==@B475 call s1.bat DIS

goto end

:end
message0 13 "OK"
pause
s.bat

:exit
message0 13 "OK"
pause
ichs5
