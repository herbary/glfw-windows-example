@echo off
setlocal EnableDelayedExpansion
set _root_path=%cd%
cd %~dp0

call :init-compiler-options .bat~opt
set _opts=%__last_init_compiler_options_result%

call :init-source-files .bat~src
set _srcs=%__last_init_source_files_result%

call :init-library-files .bat~lib
set _libs=%__last_init_library_files_result%

call :init-compiler-output .bat~out .bat~exe .bat~bin
set _outp=%__last_init_compiler_output_result%

clang-cl %_opts% %_srcs% %_libs% -o %_outp%

cd %_root_path%
endlocal
exit /b


:init-compiler-options
setlocal
call :read-first-line %1
set __opt_path=%__last_read_first_line_result%

call :read-every-line %__opt_path%
set __opt_text=%__last_read_every_line_result%

call :trim %__opt_text%
set __opt_text=%__last_trim_result%
endlocal & set __last_init_compiler_options_result=%__opt_text%
exit /b


:init-source-files
setlocal
set __src_files=
for /f "tokens=* delims=" %%a in (%~1) do (
    call :glob %%a *.c
    set __src_files=!__src_files! !__last_glob_result!
)

call :trim %__src_files%
set __src_files=%__last_trim_result%
endlocal & set __last_init_source_files_result=%__src_files%
exit /b


:init-library-files
setlocal
call :read-every-line %1
set __library_files=%__last_read_every_line_result%

call :trim %__library_files%
set __library_files=%__last_trim_result%
endlocal & set __last_init_library_files_result=%__library_files%
exit /b


:init-compiler-output
setlocal
call :read-first-line %1
set __out_path=%__last_read_first_line_result%

call :read-first-line %2
set __exe_name=%__last_read_first_line_result%

md %__out_path% 1>nul 2>nul && (
    call :read-first-line %3
    set __bin_path=!__last_read_first_line_result!

    for /f "tokens=* delims=" %%a in ('where /r !__bin_path! *.dll 2^>nul') do (
        copy %%a %__out_path% 1>nul
    )
)
endlocal & set __last_init_compiler_output_result=%__out_path%\%__exe_name%
copy nul %__last_init_compiler_output_result%.local 1>nul
exit /b


:read-first-line
set /p __last_read_first_line_result=<%1
exit /b


:read-every-line
setlocal
set __text_lines=
for /f "tokens=* delims=" %%a in (%~1) do (
    set __text_lines=!__text_lines! %%a
)
endlocal & set __last_read_every_line_result=%__text_lines%
exit /b


:glob
setlocal
set __glob_files=
for /f "tokens=* delims=" %%a in ('where /r %1 %~2 2^>nul') do (
    set __glob_files=%%a !__glob_files!
)
endlocal & set __last_glob_result=%__glob_files%
exit /b


:trim
set __last_trim_result=%*
exit /b
