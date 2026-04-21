#!/usr/bin/env bash

# Fetch all monitor data from Hyprland in JSON format
MONITORS=$(hyprctl monitors -j)

# Extract the active workspace ID of the first monitor that is NOT currently focused
TARGET_WORKSPACE=$(echo "$MONITORS" | jq -r '.[] | select(.focused == false) | .activeWorkspace.id' | head -n 1)

# Ensure we actually found a valid workspace ID
if [[ -n "$TARGET_WORKSPACE" && "$TARGET_WORKSPACE" != "null" ]]; then
    # Move the currently active window to that workspace
    hyprctl dispatch movetoworkspace "$TARGET_WORKSPACE"

    # Uncomment the line below if you also want your focus to follow the window to the new monitor
    # hyprctl dispatch workspace "$TARGET_WORKSPACE"
else
    echo "Error: Could not determine the target workspace on the other monitor."
    exit 1
fi
