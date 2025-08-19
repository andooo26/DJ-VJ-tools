@echo off
setlocal enabledelayedexpansion

set "OUTPUT_DIR=conv"

if not exist "%OUTPUT_DIR%" (
    mkdir "%OUTPUT_DIR%"
)

set EXTENSIONS=mp3 wav flac m4a aac ogg wma alac aiff

for %%E in (%EXTENSIONS%) do (
    for %%F in (*.^%%E) do (
        if exist "%%F" (
            set "INPUT=%%F"
            set "FILENAME=%%~nF"
            echo èàóùíÜ: %%F Å® %OUTPUT_DIR%\!FILENAME!.mp3
            ffmpeg -y -i "%%F" -codec:a libmp3lame -b:a 320k "%OUTPUT_DIR%\!FILENAME!.mp3"
        )
    )
)

echo èàóùÇ™äÆóπÇµÇ‹ÇµÇΩ
pause
