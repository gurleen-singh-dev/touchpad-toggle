#!/bin/bash
DEVICE="syna2ba6:00-06cb:cef5-touchpad"
STATE_FILE="$HOME/.config/hypr/touchpad.state"
if [ -f "$STATE_FILE" ]; then
    STATE=$(cat "$STATE_FILE")
    if [ "$STATE" = "disabled" ]; then
        hyprctl eval "hl.device({ name = '$DEVICE', enabled = false })"
    else
        hyprctl eval "hl.device({ name = '$DEVICE', enabled = true })"
    fi
fi