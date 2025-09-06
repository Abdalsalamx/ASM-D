#!/bin/bash

# Rofi Power Menu for Hyprland with Large Emojis
# Clean and simple design with clear ordering

# Options with large icons
lock="🔒  LockScreen"
suspend="💤  Suspend"
logout="🚪  Logout"
reboot="🔃  Reboot"
shutdown="🛑  Shutdown"

ROFI_THEME="$HOME/.config/rofi/style/style1.rasi"

# Show menu with rofi
chosen=$(printf "%s\n%s\n%s\n%s\n%s" \
    "$lock" "$suspend" "$logout" "$reboot" "$shutdown" \
    | rofi -dmenu -i -p "System Menu" -theme "$ROFI_THEME")

case "$chosen" in
    "$lock")
        hyprlock
        ;;
    "$suspend")
        systemctl suspend
        ;;
    "$logout")
        hyprctl dispatch exit
        ;;
    "$reboot")
        systemctl reboot
        ;;
    "$shutdown")
        systemctl poweroff
        ;;
    *)
        exit 0
        ;;
esac
