# Hyprland Touchpad Toggle

Persistent touchpad enable/disable toggle for Hyprland, bound to a single keypress (e.g. `Fn+M`). Unlike simple toggle scripts, the touchpad state is written to a file and **restored on every Hyprland session start** — so if you disable the touchpad, it stays disabled across reboots and reloads until you explicitly toggle it again.

## Why

Hyprland's per-device `enabled` option has no built-in persistence and no built-in toggle keybind. These two scripts solve that:

- `toggletouchpad.sh` — flips the touchpad on/off and remembers the new state
- `restore_touchpad.sh` — re-applies the last known state on login (run via `hyprland.start` / `exec-once`)

## Requirements

- Hyprland
- `notify-send` (from `libnotify`) for toggle notifications
- Your touchpad's exact device name from `hyprctl devices`
