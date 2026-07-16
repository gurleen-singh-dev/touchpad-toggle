#!/bin/bash
DEVICE="<touchpad-name>"
STATE_FILE="$HOME/.config/hypr/touchpad.state"
if [ -f "$STATE_FILE" ]; then
    STATE=$(cat "$STATE_FILE")
    if [ "$STATE" = "disabled" ]; then
        hyprctl eval "hl.device({ name = '$DEVICE', enabled = false })"
    else
        hyprctl eval "hl.device({ name = '$DEVICE', enabled = true })"
    fi
fi