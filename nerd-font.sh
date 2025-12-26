#!/bin/bash

FONT_DIR="$HOME/.local/share/fonts"
URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
ZIP_FILE="JetBrainsMono.zip"

echo "get nerd font..."
mkdir -p "$FONT_DIR"
cd "$FONT_DIR" || { echo "could not access $FONT_DIR"; exit 1; }

# Download font package
if wget -q --show-progress "$URL"; then
    echo "download successful"
else
    echo "download failed... please check your internet connection or the URL"
    exit 1
fi

unzip -o "$ZIP_FILE" -d ./ 
rm "$ZIP_FILE"

echo "system font cache..."
fc-cache -fv > /dev/null
echo "complete!"
