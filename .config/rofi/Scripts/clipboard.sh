#!/bin/bash

# Check if cliphist and rofi are installed
if ! command -v cliphist &> /dev/null; then
    echo "cliphist is not installed. Please install it first."
    exit 1
fi

if ! command -v rofi &> /dev/null; then
    echo "rofi is not installed. Please install it first."
    exit 1
fi

# Show clipboard history using rofi and let user pick one
selected=$(cliphist list | rofi -dmenu -i -p "Clipboard History")

# If something was selected, copy it to clipboard
if [ -n "$selected" ]; then
    cliphist decode <<< "$selected" | wl-copy
fi

