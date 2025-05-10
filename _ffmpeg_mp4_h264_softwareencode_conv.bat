@echo off
setlocal enabledelayedexpansion

set "INPUT_FOLDER=%~dp0"
set "OUTPUT_FOLDER=%INPUT_FOLDER%conv"

if not exist "%OUTPUT_FOLDER%" (
    mkdir "%OUTPUT_FOLDER%"
)

echo start

for %%F in (*.mp4 *.mov *.avi *.mkv *.wmv *.flv *.webm) do (
    set "INPUT_FILE=%%F"
    set "FILENAME=%%~nF"
    echo 処理中: !INPUT_FILE!
    
    ffmpeg -i "!INPUT_FILE!" -c:v libx264 -preset medium -crf 23 -c:a aac -b:a 128k "%OUTPUT_FOLDER%\!FILENAME!.mp4"
    
    if exist "%OUTPUT_FOLDER%\!FILENAME!.mp4" (
        echo 変換完了: !FILENAME!.mp4 を削除
        del "%%F"
    ) else (
        echo エラー: !FILENAME!.mp4 の変換に失敗しました
    )
)

echo done
pause