#!/bin/bash

cat /home/asan/.config/waybar/scripts/changerStyle1.css > /home/asan/.config/waybar/style.css
cat /home/asan/.config/waybar/scripts/changeConfig2.jsonc > /home/asan/.config/waybar/config.jsonc
killall waybar
waybar
