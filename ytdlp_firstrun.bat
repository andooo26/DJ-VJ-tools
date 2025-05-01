@echo off
setlocal enabledelayedexpansion

set /p url=URLを指定してください:

echo !url!>>"_list.txt"
echo.>>"_list.txt"

echo ダウンロード中: !url!
yt-dlp -f "ba[ext=m4a]+bv[ext=mp4]" -o "%%(channel)s_%%(title)s.%%(ext)s" "!url!"

echo 完了
pause
