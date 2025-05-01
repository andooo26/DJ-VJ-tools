@echo off
setlocal enabledelayedexpansion

for /f "usebackq delims=" %%A in ("_list.txt") do (
    echo ダウンロード中（最新5件）: %%A
    yt-dlp --max-downloads 5 -f "ba[ext=m4a]+bv[ext=mp4]" -o "%%(channel)s_%%(title)s.%%(ext)s" "%%A"
)

echo 完了
pause
