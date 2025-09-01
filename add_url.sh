#!/bin/bash

if [ $# -eq 0 ]; then
    exit 1
fi

url="$1"
file="list.txt"

if [ ! -f "$file" ]; then
    echo "$fileが見つかりません"
    exit 1
fi

if grep -Fxq "$url" "$file"; then
    echo "'$url'のURLはすでに存在します"
    exit 0
fi

{ echo "$url"; cat "$file"; } | sort -u > "${file}.tmp"
mv "${file}.tmp" "$file"

echo " '$url' を追加しました"
