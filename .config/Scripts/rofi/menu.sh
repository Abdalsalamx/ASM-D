#!/bin/bash

ROFI_THEME="$HOME/.config/rofi/style/style1.rasi"

# Custom Rofi menu for your scripts
CHOICE=$(echo -e "📸 Screenshot\n🌗 Dark/Light Mode\n🔄 System Update\n🛑 Power Menu" | rofi -dmenu -p "Select option:" -theme "$ROFI_THEME" -theme-str '
    window {height: 180px;}')

case "$CHOICE" in
    "📸 Screenshot")
        # Launch your screenshot script
        ~/.config/Scripts/rofi/Screenshots.sh
        ;;
    
    "🌗 Dark/Light Mode")
        # Launch your dark/light mode toggle script
        ~/.config/rofi/dark-light-toggle.sh
        ;;
    
    "🔄 System Update")
        # Launch your system update script
        kitty -e ~/.config/Scripts/other/update_system.sh
        ;;
    
    "🛑 Power Menu")
        # Launch your power menu script
        ~/.config/Scripts/rofi/power-menu.sh
        ;;
    
    *)
        exit 1
        ;;
esac
