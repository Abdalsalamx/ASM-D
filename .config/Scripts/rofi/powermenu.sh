#!/bin/bash

# Options with icons (FontAwesome or Nerd Fonts)
lock='  Lock'
suspend='  Suspend'
logout='  Logout'
reboot='  Reboot'
shutdown='  Shutdown'

# Rofi command (adjust style path if needed)
rofi_cmd="rofi -dmenu -i -p 'Power' -theme ~/.config/rofi/config.rasi"

# Show menu
chosen=$(echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | $rofi_cmd)

case "$chosen" in
    *Shutdown*) systemctl poweroff ;;
    *Reboot*) systemctl reboot ;;
    *Lock*)
        hyprlock
        ;;
    *Suspend*)
        systemctl suspend
        ;;
    *Logout*)
        hyprctl dispatch exit
        ;;
esac
