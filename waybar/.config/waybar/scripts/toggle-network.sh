#!/bin/bash

# Check if nm-connection-editor is running
if pgrep -x "nm-connection-editor" >/dev/null; then
    # If running, terminate the process
    pkill -x "nm-connection-editor"
else
    # If not running, start it
    nm-connection-editor &
fi
