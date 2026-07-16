#!/bin/bash
DEVICE="syna2ba6:00-06cb:cef5-touchpad"
STATE_FILE="$HOME/.config/hypr/touchpad.state"

CURRENT=$(cat "$STATE_FILE" 2>/dev/null || echo "enabled")

if [ "$CURRENT" = "enabled" ]; then
    hyprctl eval "hl.device({ name = '$DEVICE', enabled = false })"
    echo "disabled" > "$STATE_FILE"
    notify-send "Touchpad" "Disabled"
else
    hyprctl eval "hl.device({ name = '$DEVICE', enabled = true })"
    echo "enabled" > "$STATE_FILE"
    notify-send "Touchpad" "Enabled"
fi