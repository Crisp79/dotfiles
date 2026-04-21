#!/bin/bash

direction=$1

# Get current monitor and active workspace ID
monitor=$(hyprctl activeworkspace -j | jq -r '.monitor')
current_workspace=$(hyprctl activeworkspace -j | jq '.id')

# Define persistent workspaces strictly as JSON arrays
if [ "$monitor" == "DP-2" ]; then
    persistent_json="[1, 2, 3, 4, 5, 6]"
elif [ "$monitor" == "eDP-1" ]; then
    persistent_json="[11, 12, 13, 14, 15, 16]"
else
    # Fallback to current workspace if monitor is not matched
    persistent_json="[$current_workspace]"
fi

# Use jq to handle all merging, sorting, and index math
target_workspace=$(hyprctl workspaces -j | jq -r \
    --arg dir "$direction" \
    --argjson curr "$current_workspace" \
    --argjson pers "$persistent_json" \
    --arg mon "$monitor" '
    
    # 1. Get active workspace IDs for the current monitor
    [ .[] | select(.monitor == $mon) | .id ] as $active
    
    # 2. Combine active with persistent, remove duplicates, and sort
    | ($active + $pers | unique) as $all
    
    # 3. Find the index of the current workspace
    | ($all | index($curr)) as $idx
    
    # 4. Calculate the next index with loop-around logic
    | if $idx == null then
        $pers[0]
      else
        if $dir == "up" then
            ($idx - 1 + ($all | length)) % ($all | length)
        else
            ($idx + 1) % ($all | length)
        end
        | $all[.]
      end
')

# Dispatch to the calculated workspace
hyprctl dispatch split:workspace "$target_workspace"
