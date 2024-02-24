@echo off
setlocal
set _root_path=%cd%
cd %~dp0

cmd /c build.bat

call :run .bat~out .bat~exe

cd %_root_path%
endlocal
exit /b


:run
setlocal
call :read-first-line %1
set __exe_path=%__last_read_first_line_result%

call :read-first-line %2
set __exe_name=%__last_read_first_line_result%

%__exe_path%\%__exe_name%
endlocal
exit /b


:read-first-line
set /p __last_read_first_line_result=<%1
exit /b
