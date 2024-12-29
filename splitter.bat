@echo off
setlocal enabledelayedexpansion

:: Check if a file was provided
if "%~1"=="" (
    echo Please drag and drop a .asm file onto Loader.bat.
	echo.
    pause
    exit /b
)

:: Define a temporary file
set "tempFile=%~dpn1_temp.txt"

:: Read the content of the file into a variable
set "hex="
for /f "delims=" %%A in ('type "%~1"') do (
    set "hex=!hex!%%A"
)

:: Remove any spaces, line breaks, or non-hex characters from the hex string
set "hex=%hex: =%"
set "hex=%hex:,=%"
set "hex=%hex:.=%"
set "hex=%hex:-=%"

:: Initialize byte counter and line counter
set "byteCount=0"
set "lineCount=0"

:: Loop through each character pair in the hex string
set "output="
for /l %%i in (0,2,9999) do (
    set "byte=!hex:~%%i,2!"
    if not "!byte!"=="" (
        set "output=!output!!byte! "
        set /a byteCount+=1
        set /a lineCount+=1

        :: Add a newline after every 10 bytes
        if !lineCount! equ 10 (
            echo !output! >> "%tempFile%"
            set "output="
            set "lineCount=0"
        )
    ) else (
        goto :done
    )
)

:done
:: Handle any remaining bytes that didn't fill a complete line
if defined output (
    echo !output! >> "%tempFile%"
)

:: Append the byte count to the temporary file
echo. >> "%tempFile%"
echo Total Bytes: %byteCount% >> "%tempFile%"

:: Replace the original file with the temporary file
move /Y "%tempFile%" "%~1" >nul

:: Display the result and the output file location
echo Processing complete. Total Bytes: %byteCount%

endlocal
