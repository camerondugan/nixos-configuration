#!/usr/bin/env bash
sudo nix-channel --update

# Paths for GTK Settings.ini and .bak
GTK3SETTINGSPATH="/home/$USER/.config/gtk-3.0/settings.ini"
GTK3SETTINGSBAKPATH="/home/$USER/.config/gtk-3.0/settings.bak"
GTK4SETTINGSPATH="/home/$USER/.config/gtk-4.0/settings.ini"
GTK4SETTINGSBAKPATH="/home/$USER/.config/gtk-4.0/settings.bak"
GTKRC2PATH="/home/$USER/.gtkrc-2.0"
GTKRC2BAKPATH="/home/$USER/.gtkrc-2.0.bak"

# Clear out gtk settings for home-manager:
mv -f "$GTK3SETTINGSPATH" "$GTK3SETTINGSBAKPATH"
mv -f "$GTK4SETTINGSPATH" "$GTK4SETTINGSBAKPATH"
mv -f "$GTKRC2PATH" "$GTKRC2BAKPATH"

# Run test
# sudo nixos-rebuild switch --show-trace --fast
# Cosmic temporary thing:
sudo nixos-rebuild boot --flake '/home/cam/.nixos/' --accept-flake-config --impure

# Restore gtk3 settings if not generated for us
if [ ! -f "$GTK3SETTINGSPATH" ]; then
	cp -f "$GTK3SETTINGSBAKPATH" "$GTK3SETTINGSPATH"
fi
if [ ! -f "$GTK4SETTINGSPATH" ]; then
	cp -f "$GTK4SETTINGSBAKPATH" "$GTK4SETTINGSPATH"
fi
if [ ! -f "$GTKRC2PATH" ]; then
	cp -f "$GTKRC2BAKPATH" "$GTKRC2PATH"
fi

# Hyprland stuff:
# hyprctl reload
# pkill waybar && (waybar >>/dev/null) &
# disown $!
