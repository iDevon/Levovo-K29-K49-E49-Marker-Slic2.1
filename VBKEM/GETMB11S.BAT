@echo off
REM ------------------------- Main Program -----------------------------
    serupdt r 40 | find /i "11S" | lmod.com /s set MB11S@=[$2] >out.bat
    call out.bat
                                                                                                        
REM ----------------------- End & Clear Temporary Data -----------------
    inifile.com \@control.ini [ID] mb11s@=%mb11s@%
    echo MB 11S: [1;32m%mb11s@%[0m

                                
