#!/usr/bin/env bash

DIR="$HOME/Pictures/bg"

# Pick a random file (images only, safe with spaces)
file=$(find "$DIR" -type f \( \
    -iname "*.jpg" -o \
    -iname "*.jpeg" -o \
    -iname "*.png" -o \
    -iname "*.webp" \
\) -print0 | shuf -z -n1 | xargs -0)

# Exit if nothing found
[ -z "$file" ] && exit 1

# Set wallpaper with circle transition
swww img "$file" \
  --transition-type center \
  --transition-fps 60 \
  --transition-step 50
