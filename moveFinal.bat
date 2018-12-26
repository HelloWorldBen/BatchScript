REM move files 
REM \\networkshare\folder1\test*.bak to \\networkshare\folder2\

@echo OFF


REM Declare variables 
echo PARAM 1:[%1]
echo PARAM 2:[%2]

REM get execution time for debugging purposes 
for /F "tokens=2" %%i in ('date /t') do set mydate=%%i
set mytime=%time%
Echo Script Start is %mydate%:%mytime%


REM if 2 parameters are empty then throw error finish program 
IF [%1] == [] GOTO EXIT_RST
IF [%2] == [] GOTO EXIT_RST


REM get the location store it in a variable 
set loc=%1 
REM IF there exits files then begin copying else do not copy 
IF EXIST  %loc% (
	echo FILES EXIST BEGIN COPYING
	move /Y %1 %2   
	ECHO MOVED SUCCESSFULLY 
	goto EXIT_RST
 
 
REM if there Error in copying then throw ERROR send messaage to user 
IF %ERRORLEVEL% NEQ 0  (
	ECHO INSIDE ERROR  
	ECHO MOVE FAILURE  
	ECHO %ERRORLEVEL%  
	set mytime=%time%
    Echo Script Error time %mydate%:%mytime%  
	goto EXIT_RST
)
 

REM if there are no files then do not do anything  	
) ELSE (
   echo NO FILES IN FOLDER TO BE MOVED 
   REM echo %ERRORLEVEL%
   goto EXIT_RST
)


REM Exit the Program do file clean up activities 
:EXIT_RST
echo .
echo Return Code: %ERRORLEVEL%
echo A non-zero return code indicates file to be moved was not successful
echo .
set mytime=%time%
Echo Script Ended is %mydate%:%mytime%
REM This EXIT /b ERROR resets the error level 
exit /B 0


