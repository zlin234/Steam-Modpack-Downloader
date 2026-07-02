@echo off
setlocal enabledelayedexpansion

dir /ad /b > dir.txt

set "dirFile=%~dp0dir.txt"
set "originalDir=%~dp0"

set lineCount=0
:GetFirstLine
for /f "usebackq delims=" %%A in ("%dirFile%") do (
	set /a LineCount+=1
	set "firstLine=%%A"
	goto :Continue
)

:Continue
cd %firstLine%
for %%F in ("%TargetDir%*") do (
	set "FileName=%%~nxF"

	set "Extension=!FileName:~-4!"

	if "!Extension!"==".mod" (
		set "folderName=%%~nF"
	)
)
cd %originalDir%
ren "%firstLine%" "%folderName%"

more +1 "%dirFile%" > "temp.txt"
move /y "temp.txt" "%dirFile%"

echo %firstLine% renamed to %folderName%

timeout /t 1

goto :GetFirstLine

pause
