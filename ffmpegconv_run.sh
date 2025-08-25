#!/bin/bash

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
INPUT_FOLDER="$BASE_DIR/unconv"
OUTPUT_FOLDER="$BASE_DIR/conved"

echo "start"

# フォルダがなければ終了
if [ ! -d "$INPUT_FOLDER" ]; then
    echo " $INPUT_FOLDER が見つかりません"
    exit 1
fi

# 再帰的に探索
find "$INPUT_FOLDER" -type f \( \
  -iname "*.mp4" -o -iname "*.mov" -o -iname "*.avi" -o \
  -iname "*.mkv" -o -iname "*.wmv" -o -iname "*.flv" -o -iname "*.webm" \
\) | while read -r f; do
    relpath="${f#$INPUT_FOLDER/}"
    filename="$(basename "$f" | sed 's/\.[^.]*$//')"
    outdir="$OUTPUT_FOLDER/$(dirname "$relpath")"
    outfile="$outdir/$filename.mp4"

    # 出力先ディレクトリの作成
    mkdir -p "$outdir"

    # 存在する場合はスキップ
    if [ -f "$outfile" ]; then
        echo "スキップ: $outfile は既に存在します"
        continue
    fi

    echo "処理中: $f"

    # H.264/MP4に変換
    ffmpeg -nostdin -i "$f" -c:v libx264 -preset medium -crf 23 -c:a aac -b:a 128k "$outfile"

    if [ -f "$outfile" ]; then
        echo "変換完了: $outfile"
    else
        echo "エラー: $outfile の変換に失敗しました"
    fi
done

echo "done"
read -p "Press Enter to continue..."
