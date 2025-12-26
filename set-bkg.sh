#!/usr/bin/env bash

IMAGE_NAME="${1:?Error: Provide image name as first argument}"
INI_FILE="$HOME/.config/wayfire.ini"
IMAGE_PATH="~/.striped/${IMAGE_NAME}.png"
NEW_BG_CMD="swaybg -i $IMAGE_PATH -m fill"

if [[ ! -f "$HOME/.striped/${IMAGE_NAME}.png" ]]; then
    echo "Error: Image $HOME/.striped/${IMAGE_NAME}.png not found" >&2
    exit 1
fi

update_ini() {
    local ini="$1" key="$2" value="$3"
    local section="" updated=false
    
    awk -v key="$key" -v value="$value" '
    /^[ \t]*\[/ { section = substr($0, 2, length($0)-2); next }
    /^[ \t]*'"$key"'[ \t]*=/ && section != "" {
        print "    '"$key"' = " value;
        updated=1; next
    }
    { print }
    END {
        if (!updated && section != "") {
            print "    '"$key"' = " value
        }
    }' "$ini" > "$ini.tmp" && mv "$ini.tmp" "$ini"
}

cp "$INI_FILE" "$INI_FILE.bak"

# Update INI
if grep -qE '^\s*\[\w+\]' "$INI_FILE"; then
    awk '/^\[/{section=$0; next} /^\s*background\s*=/ && section{print section " updated"; exit 0}' "$INI_FILE" || \
    update_ini "$INI_FILE" "background" "$NEW_BG_CMD"
else
    sed -i "s/^\s*background\s*=.*/background = $NEW_BG_CMD/" "$INI_FILE" || \
    echo "background = $NEW_BG_CMD" >> "$INI_FILE"
fi

pkill -f swaybg 2>/dev/null || true
sleep 0.1
setsid swaybg -i "$HOME/.striped/${IMAGE_NAME}.png" -m fill >/dev/null 2>&1 &

echo "updated to: $NEW_BG_CMD"
echo "backed up to: $INI_FILE.bak"
