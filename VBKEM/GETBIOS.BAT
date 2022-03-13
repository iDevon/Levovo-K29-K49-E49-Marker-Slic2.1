@echo off
REM ------------------------- Main Program -----------------------------
    smbios.exe | find "BIOS Version" | lmod /S=( Bios@=[$3] | aset /f
    aset.exe BiosHD@=left('%Bios@%',2)
    aset.exe BiosV@=copy('%Bios@%',5,2)

REM ----------------------- End & Clear Temporary Data -----------------
    echo BIOS: [1;32m%Bios@%[0m
    inifile.com @control.ini [ID] Bios@=%Bios@%
    inifile.com @control.ini [ID] BiosHD@=%BiosHD@%
    inifile.com @control.ini [ID] BiosV@=%BiosV@%
