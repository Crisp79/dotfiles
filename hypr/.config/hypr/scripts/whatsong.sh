#!/bin/bash

PLAYERS="spotify"
STATUS=$(playerctl --player="$PLAYERS" status 2>/dev/null)

if [ "$STATUS" = "Playing" ] || [ "$STATUS" = "Paused" ]; then
    PLAYER_NAME=$(playerctl --player="$PLAYERS" metadata --format '{{lc(playerName)}}')
    OUTPUT=$(playerctl --player="$PLAYERS" metadata --format '{{title}} - {{artist}} ({{album}})')
    OUTPUT="${OUTPUT// ()/}"

    # Manually assign icons based on the player name
    if [ "$PLAYER_NAME" = "spotify" ]; then
        ICON=" "
    elif [ "$PLAYER_NAME" = "firefox" ]; then
        ICON=" "
    else
        ICON=" "
    fi

    # Print the final combined string
    echo "$ICON $OUTPUT"
else
    # Output nothing if no media is playing
    echo ""
fi
