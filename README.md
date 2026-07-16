# Hyprland Touchpad Toggle

Persistent touchpad enable/disable toggle for Hyprland, bound to a keyboard shortcut. Unlike simple toggle scripts, the touchpad state is written to a file and **restored on every Hyprland session start** — so if you disable the touchpad, it stays disabled across reboots and reloads until you explicitly toggle it again.

## Why

Hyprland's per-device `enabled` option has no built-in persistence and no built-in toggle keybind. These two scripts solve that:

- `toggletouchpad.sh` — flips the touchpad on/off and remembers the new state
- `restore_touchpad.sh` — re-applies the last known state on login (run via `hyprland.start` / `exec-once`)

## Requirements

- Hyprland
- `notify-send` (from `libnotify`) for toggle notifications
- Your touchpad's exact device name from `hyprctl devices`

## Setup
 
### 1. Find your device name
 
```bash
hyprctl devices
```
 
Look under `mice:` for your touchpad, e.g. `something-something-something`. Copy it exactly, including any colons.
 
### 2. Install the scripts
 
```bash
git clone https://github.com/gurleen-singh-dev/touchpad-toggle.git
cd touchpad-toggle
mkdir -p ~/.config/hypr/scripts
cp toggletouchpad.sh restore_touchpad.sh ~/.config/hypr/scripts/
chmod +x ~/.config/hypr/scripts/toggletouchpad.sh ~/.config/hypr/scripts/restore_touchpad.sh
```
Edit the `DEVICE` variable at the top of both scripts to match your device name.
 
### 3. Set the correct command syntax
 
Hyprland changed how per-device settings are applied at runtime depending on your version:
 
| Hyprland version | Config parser | Command to apply the setting |
|---|---|---|
| < 0.55 | Legacy (`hyprland.conf`) | `hyprctl keyword "device[$DEVICE]:enabled" <bool>` |
| ≥ 0.55 | Lua (`hyprland.lua`) | `hyprctl eval "hl.device({ name = '$DEVICE', enabled = <bool> })"` |
 
The scripts in this repo are written for **Hyprland ≥ 0.55 (Lua config)** and use the `hyprctl eval` / `hl.device()` form as-is.
 
If you're on a pre-0.55 install with a legacy `hyprland.conf`, you'll need to edit both scripts and replace every `hyprctl eval "hl.device({ name = '$DEVICE', enabled = <bool> })"` line with `hyprctl keyword "device[$DEVICE]:enabled" <bool>` (keeping `true`/`false` as appropriate on each line).
 
> **Note:** the plain `device:<name>:enabled` syntax (no brackets) is broken for any device name containing a colon, which includes most laptop touchpads — always use the bracketed `device[<name>]:enabled` form if you're modifying the scripts for a legacy config.

 
### 4. Add the keybind
Add following lines to your keybinding config files

**Lua (`hyprland.lua`):**
```lua
hl.bind("XF86TouchpadToggle", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggletouchpad.sh"))
```
 
**Legacy (`hyprland.conf`):**
```
bind = , XF86TouchpadToggle, exec, ~/.config/hypr/scripts/toggletouchpad.sh
```
(swap `XF86TouchpadToggle` with your desired key shortcut, check with `wev` if unsure.
 
### 5. Restore state on startup

Add following line to autorun configs
 
**Lua**, inside your `hl.on("hyprland.start", function() ... end)` block:
```lua
hl.exec_cmd("~/.config/hypr/scripts/restore_touchpad.sh")
```
 
**Legacy**, in `hyprland.conf`:
```
exec-once = ~/.config/hypr/scripts/restore_touchpad.sh
```
