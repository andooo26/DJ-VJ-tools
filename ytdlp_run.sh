#!/bin/bash

URL_LIST="list.txt"
SAVE_DIR="unconv"

download_videos() {
  local url="$1"
  echo "Downloading: $url"

  yt-dlp \
    --windows-filenames \
    --no-overwrites \
    -f "ba[ext=m4a]+bv[ext=mp4]" \
    -o "$SAVE_DIR/%(channel)s/%(channel)s_%(title)s.%(ext)s" \
    "${url}?view=0&sort=dd" \
  2>&1 | while IFS= read -r line; do
    echo "$line"
    if [[ "$line" == *"has already been downloaded"* ]]; then
      break
    fi
  done
}

while IFS= read -r base_url || [[ -n $base_url ]]; do
  [[ -z "$base_url" || "$base_url" =~ ^# ]] && continue

  url_videos="${base_url}/videos"
  download_videos "$url_videos"

  url_streams="${base_url}/streams"
  download_videos "$url_streams"

done < "$URL_LIST"

echo "Done"