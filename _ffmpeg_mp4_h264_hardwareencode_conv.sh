#!/bin/bash

INPUT_FOLDER="$(dirname "$0")"
OUTPUT_FOLDER="$INPUT_FOLDER/conv"

mkdir -p "$OUTPUT_FOLDER"

echo "start"

shopt -s nullglob
for FILE in "$INPUT_FOLDER"/*.{mp4,mov,avi,mkv,wmv,flv,webm}; do
    [ -f "$FILE" ] || continue
    BASENAME=$(basename "$FILE")
    FILENAME="${BASENAME%.*}"

    echo "処理中: $FILE"

    ffmpeg -hwaccel cuda -i "$FILE" -c:v h264_nvenc -preset p3 -cq 23 -c:a aac -b:a 128k "$OUTPUT_FOLDER/$FILENAME.mp4"

    if [ -f "$OUTPUT_FOLDER/$FILENAME.mp4" ]; then
        echo "変換完了: $FILENAME.mp4 を削除"
        rm "$FILE"
    else
        echo "エラー: $FILENAME.mp4 の変換に失敗しました"
    fi
done

echo "done"
read -p "Press enter to continue..."
