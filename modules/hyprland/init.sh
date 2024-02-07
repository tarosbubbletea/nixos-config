#!/usr/bin/env bash
# daemon
swww init &

# setting wallpaper
swww img ~/Wallpapers/wall.jpg &

# nm applet daemon
nm-applet --indicator &

waybar &
