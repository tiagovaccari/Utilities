@echo off
setlocal

rem Prompt user to enter the port number
set /p port=Enter the port number of the process you want to kill: 

rem Get the Process ID (PID) for the given port
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :%port%') do (
    set PID=%%a
    goto :found
)

rem If no process is found, notify the user and exit
echo No process is running on port %port%.
goto :end

:found
echo Process found on port %port% with PID: %PID%

rem Prompt user to confirm termination
set /p confirm=Do you want to kill this process (PID %PID%)? (y/n): 
if /i "%confirm%"=="y" (
    taskkill /PID %PID% /F
    echo Process (PID %PID%) has been terminated.
) else (
    echo Operation canceled.
)

:end
endlocal
