@echo off
setlocal enabledelayedexpansion

set "INPUT_FOLDER=%~dp0"
set "OUTPUT_FOLDER=%INPUT_FOLDER%converted"

if not exist "%OUTPUT_FOLDER%" (
    mkdir "%OUTPUT_FOLDER%"
)

echo start

for %%F in (*.mp4 *.mov *.avi *.mkv *.wmv *.flv *.webm) do (
    set "INPUT_FILE=%%F"
    set "FILENAME=%%~nF"
    echo !INPUT_FILE!
    ffmpeg -i "!INPUT_FILE!" -c:v libx264 -preset medium -crf 23 -c:a aac -b:a 128k "%OUTPUT_FOLDER%\!FILENAME!.mp4"
)

echo done
pause
