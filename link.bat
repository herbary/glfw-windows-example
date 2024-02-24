@echo off
setlocal EnableDelayedExpansion
set _root_path=%cd%
cd %~dp0

call :link .bat~inc .bat~ext

cd %_root_path%
endlocal
exit /b


:link
setlocal
call :read-first-line %1
set __inc_path=%__last_read_first_line_result%

call :remove-tree-path %__inc_path%
for /f "tokens=* delims=" %%a in (%~2) do (
    call :mklink %__inc_path% %%~a
)
endlocal
exit /b


:mklink
setlocal
set __inc_path=%1
set __src_path=%2

for /f "tokens=* delims=" %%a in ('where /r %__src_path% *.h 2^>nul') do (
    set __relative_path=%%a
    set __relative_path=!__relative_path:%~dp0%__src_path%\=!

    call :count !__relative_path! \
    set __count=!__last_count_result!

    call :count %__inc_path% \
    set /a __count+=!__last_count_result!+1

    call :mult ..\ !__count!
    set __mult_path=!__last_mult_result!

    set __link_path=%__inc_path%\!__relative_path!
    set __target_path=!__mult_path!%__src_path%\!__relative_path!

    mkdir !__link_path:\%%~nxa=! 1>nul 2>nul
    mklink !__link_path! !__target_path! 2>nul
)
endlocal
exit /b


:read-first-line
set /p __last_read_first_line_result=<%1
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


:mult
setlocal
set __string=%~1
set __count=%~2

set __last_mult_result=
for /l %%a in (1, 1, %__count%) do (
    set __last_mult_result=!__last_mult_result!%__string%
)

call :trim %__last_mult_result%
endlocal & set __last_mult_result=%__last_trim_result%
exit /b


:count
setlocal
set __test_path=%~1
set __split_path=!__test_path:%~2= !

call :trim %__split_path%
set __split_path=%__last_trim_result%

set __count=-1

:loop
set __temp_path=%__split_path%
set __split_path=!__split_path:* =!

set /a __count+=1
if ["%__split_path%"] neq ["%__temp_path%"] (
    goto :loop
)

endlocal & set __last_count_result=%__count%
exit /b


:trim
set __last_trim_result=%*
exit /b
