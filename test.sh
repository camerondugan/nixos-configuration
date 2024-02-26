#!/usr/bin/env bash
sudo nix-channel --update
sudo nixos-rebuild switch --show-trace --fast

# Paths for GTK Settings.ini and .bak
GTK3SETTINGSPATH="/home/$USER/.config/gtk-3.0/settings.ini"
GTK4SETTINGSPATH="/home/$USER/.config/gtk-4.0/settings.ini"
GTK3SETTINGSBAKPATH="/home/$USER/.config/gtk-3.0/settings.bak"
GTK4SETTINGSBAKPATH="/home/$USER/.config/gtk-4.0/settings.bak"

# Clear out gtk settings for home-manager:
mv "$GTK3SETTINGSPATH" "$GTK3SETTINGSBAKPATH"
mv "$GTK4SETTINGSPATH" "$GTK4SETTINGSBAKPATH"

# Restore gtk3 settings if not generated for us
if [ ! -f "$GTK3SETTINGSPATH" ]; then
	cp "$GTK3SETTINGSBAKPATH" "$GTK3SETTINGSPATH"
fi
if [ ! -f "$GTK4SETTINGSPATH" ]; then
	cp "$GTK4SETTINGSBAKPATH" "$GTK4SETTINGSPATH"
fi

# Hyprland stuff:
# hyprctl reload
# pkill waybar && (waybar >>/dev/null) &
# disown $!
