#!/bin/bash

echo "" > /home/asan/.config/hypr/hyprpaper.conf
cat /home/asan/.config/hypr/scripts_for_hyprpaper/hyprpaper_example2.conf > /home/asan/.config/hypr/hyprpaper.conf

killall hyprpaper
hyprpaper &







