#!/bin/bash

# Simple rofi menu example
options="🌐 Browser\n📁 Files\n⚙️ Settings\n🔒 Lock\n⏻ Power"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "Menu" -theme-str 'window {width: 300px;}')

case $chosen in
    "🌐 Browser")
        firefox &
        ;;
    "📁 Files")
        thunar &
        ;;
    "⚙️ Settings")
        xfce4-settings-manager &
        ;;
    "🔒 Lock")
        i3lock -c 000000 &
        ;;
    "⏻ Power")
        rofi -show power-menu -modi "power-menu:rofi-power-menu" &
        ;;
esac
