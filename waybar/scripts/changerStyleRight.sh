#!/bin/bash

cat /home/asan/.config/waybar/scripts/changerStyle3.css > /home/asan/.config/waybar/style.css
cat /home/asan/.config/waybar/scripts/changeConfig1.jsonc > /home/asan/.config/waybar/config.jsonc
killall waybar
waybar
