#!/bin/bash
# Force output flushing to ensure Waybar gets the updates instantly
stdbuf -oL zscroll --length 20 \
    --delay 0.2 \
    --scroll-padding "    " \
    --match-command "playerctl -p spotify,%any status" \
    --match-text "Playing" "--before-text ' ' --scroll 1" \
    --match-text "Paused" "--before-text ' ' --scroll 0" \
    --update-check true "playerctl -p spotify,%any metadata --format '{{ artist }} - {{ title }}'" &
wait
