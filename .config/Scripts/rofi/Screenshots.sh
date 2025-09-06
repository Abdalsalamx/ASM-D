#!/bin/bash

# Screenshot directory
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

# Generate filename with timestamp
FILENAME="Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png"
FULL_PATH="$SCREENSHOT_DIR/$FILENAME"

ROFI_THEME="$HOME/.config/rofi/style/style1.rasi"

# Show rofi menu with options
CHOICE=$(echo -e "🖥️  Active Monitor\n🎯  Selected Region\n🪟  Specific Window" \
| rofi -dmenu -p "Select capture type:" -theme "$ROFI_THEME"\
 -theme-str 'window{height:140px;}')

case "$CHOICE" in
    "🖥️  Active Monitor")
        MODE="Active Monitor"
        hyprshot -m output -m active -o "$SCREENSHOT_DIR" -f "$FILENAME" -s
        ;;
    "🎯  Selected Region")
        MODE="Selected Region" 
        hyprshot -m region -o "$SCREENSHOT_DIR" -f "$FILENAME" -s
        ;;
    "🪟  Specific Window")
        MODE="Specific Window"
        hyprshot -m window -o "$SCREENSHOT_DIR" -f "$FILENAME" -s
        ;;
    *)
        exit 1
        ;;
esac

# Check if screenshot was successful
if [ -f "$FULL_PATH" ]; then
    # Send notification with capture mode and screenshot preview
    notify-send "Screenshot Captured" "Mode: $MODE\nSaved to: $FULL_PATH" -i "$FULL_PATH"
else
    notify-send "Screenshot Failed" "Mode: $MODE\nPlease try again"
fi
