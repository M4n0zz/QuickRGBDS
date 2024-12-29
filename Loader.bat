@echo off
REM Check if a file was provided
if "%~1"=="" (
    echo Please exit and drag and drop an .asm file into the Loader.bat.
    echo.
    pause
    exit /b
)

REM Get the full path of the dragged file
set "filepath=%~1"

REM Get the filename without extension and the directory path of the dragged file
set "filename=%~n1"
set "filedir=%~dp1"

REM Get the directory of the batch script (to copy files and create 'output' folder there)
set "scriptdir=%~dp0"

REM Copy the .asm file to the batch script's directory
copy "%filepath%" "%scriptdir%%filename%.asm" >nul

REM Navigate to the script's directory
cd /d "%scriptdir%"
echo.
echo Assembling..
REM Command 1: Assemble the copied .asm file to create an object file
rgbasm -o "%filename%.o" "%filename%.asm"
echo.
echo Linking..
REM Command 2: Link the object file to create a .gb file
rgblink -x -o "%filename%.gb" "%filename%.o"

REM Check if the .gb file was created
if exist "%filename%.gb" (
	echo.
    echo Reversing to HEX..
    REM Command 3: Convert the .gb file to a hex file
    xxd -p "%filename%.gb" > "%filename%.hex"
	echo.
    echo Splitting to bytes...
    echo.
    REM Command 4: Call splitter.bat with the .hex file
    call splitter.bat "%filename%.hex"

    REM Move the generated .hex file to the original location of the .asm file
    copy "%filename%.hex" "%filedir%" >nul

REM Delete temp files
del "%filename%.hex"
if exist "%filename%.asm" del /Q "%filename%.asm"
if exist "%filename%.o" del /Q "%filename%.o"
if exist "%filename%.gb" del /Q "%filename%.gb"
	
    REM Open the final .hex file with Notepad in a separate process and wait briefly
    notepad "%filedir%%filename%.hex"
    
    REM Exit the script immediately after launching Notepad
    exit
) else (
	echo.
    echo Failed to create .gb file. Skipping HEX conversion and byte splitting.
)



echo.
pause
