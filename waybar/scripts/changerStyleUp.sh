#!/bin/bash

cat /home/asan/.config/waybar/scripts/changerStyle4.css > /home/asan/.config/waybar/style.css
cat /home/asan/.config/waybar/scripts/changeConfig3.jsonc > /home/asan/.config/waybar/config.jsonc
killall waybar
waybar
