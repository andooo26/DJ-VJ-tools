@echo off
setlocal enabledelayedexpansion

set /p url=URL���w�肵�Ă�������:

echo !url!>>"_list.txt"
echo.>>"_list.txt"

echo �_�E�����[�h��: !url!
yt-dlp -f "ba[ext=m4a]+bv[ext=mp4]" -o "%%(channel)s_%%(title)s.%%(ext)s" "!url!"

echo ����
pause
