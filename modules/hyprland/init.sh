#!/usr/bin/env bash
# daemon
swww init &

# setting wallpaper
swww img ~/wall.jpg &

# nm applet daemon
nm-applet --indicator &
# blueman-applet &

waybar &
