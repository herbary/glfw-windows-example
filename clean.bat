@echo off
setlocal
set _root_path=%cd%
cd %~dp0

call :clean .bat~out

cd %_root_path%
endlocal
exit /b


:clean
setlocal
call :read-first-line %1
set __out_path=%__last_read_first_line_result%

call :remove-tree-path %__out_path%
endlocal
exit /b


:remove-tree-path
setlocal
set __root_path=%cd%

call :trim %~1
set __remv_path="%__last_trim_result%"

cd %__remv_path% 1>nul 2>nul
if [%cd%] equ [%__root_path%] (
    exit /b
)
cd %__root_path% 1>nul

del /s /q /f %__remv_path% 1>nul 2>nul
rd /s /q %__remv_path% 1>nul 2>nul
endlocal
exit /b


:read-first-line
set /p __last_read_first_line_result=<%1
exit /b


:trim
set __last_trim_result=%*
exit /b
