@echo off
REM ------------------------- Main Program -----------------------------
    inifile.com \@control.ini [SFCS] Sfcs_Upn>out.bat
    call out.bat
    set Pn@=%Sfcs_Upn%

REM ----------------------- End & Clear Temporary Data -----------------
    if exist out.bat del out.bat
    echo P/N: [1;32m%Pn@%[0m
    inifile.com \@control.ini [ID] Pn@=%Pn@%
