::=========================== File Header ==============================
:: Description:  Set test log
::======================== Requriment(s)  ==============================
::-- %stage% Test stage
::-- %Func%  Test itme
::-- %1 => START,END,FAIL
::-- %2 => Fail Message
::-- %3 => Other
::======================== Modified History ============================
:: 2008-01-12 V1.0 WKS1TE - First release        
::======================================================================
@echo off
REM ----------------------- Main Program -----------------------------
:Set_Log
logecho $Y-$M-$D $h:$m:$s, %stage%, %Func%, [%1], %2 %3 >>%drv%\@LOG.TXT

:END
