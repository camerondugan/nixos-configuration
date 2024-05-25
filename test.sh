#!/usr/bin/env bash
sudo nix-channel --update

# Paths for GTK Settings.ini and .bak
GTK3SETTINGSPATH="/home/$USER/.config/gtk-3.0/settings.ini"
GTK4SETTINGSPATH="/home/$USER/.config/gtk-4.0/settings.ini"
GTK3SETTINGSBAKPATH="/home/$USER/.config/gtk-3.0/settings.bak"
GTK4SETTINGSBAKPATH="/home/$USER/.config/gtk-4.0/settings.bak"

# Clear out gtk settings for home-manager:
mv -f "$GTK3SETTINGSPATH" "$GTK3SETTINGSBAKPATH"
mv -f "$GTK4SETTINGSPATH" "$GTK4SETTINGSBAKPATH"

# Run test
sudo nixos-rebuild switch --show-trace --fast

# Restore gtk3 settings if not generated for us
if [ ! -f "$GTK3SETTINGSPATH" ]; then
	cp -f "$GTK3SETTINGSBAKPATH" "$GTK3SETTINGSPATH"
fi
if [ ! -f "$GTK4SETTINGSPATH" ]; then
	cp -f "$GTK4SETTINGSBAKPATH" "$GTK4SETTINGSPATH"
fi

# Hyprland stuff:
# hyprctl reload
# pkill waybar && (waybar >>/dev/null) &
# disown $!
