#!/usr/bin/env bash

arg1="$*" # all text after command
if [ -z "$arg1" ]; then
	echo "Please use \"./upload.sh description of changes\""
	exit 1
fi

# Paths for GTK Settings.ini and .bak
GTK3SETTINGSPATH="/home/$USER/.config/gtk-3.0/settings.ini"
GTK4SETTINGSPATH="/home/$USER/.config/gtk-4.0/settings.ini"
GTK3SETTINGSBAKPATH="/home/$USER/.config/gtk-3.0/settings.bak"
GTK4SETTINGSBAKPATH="/home/$USER/.config/gtk-4.0/settings.bak"

# Switch
sudo nix-channel --update
# Clear out gtk settings for home-manager
mv "$GTK3SETTINGSPATH" "$GTK3SETTINGSBAKPATH"
mv "$GTK4SETTINGSPATH" "$GTK4SETTINGSBAKPATH"

if sudo nixos-rebuild switch --upgrade --fast --show-trace; then
	# hyprctl reload
	git add . && (
		git commit -m "$arg1"
		git push
		git push github
	)
else
	# Build for next boot
	if sudo nixos-rebuild boot --upgrade --fast --show-trace; then
		# hyprctl reload
		git add . && (
			git commit -m "$arg1"
			git push
			git push github
		)
	fi
fi

# Restore gtk3 settings if not generated for us
if [ ! -f "$GTK3SETTINGSPATH" ]; then
	cp "$GTK3SETTINGSBAKPATH" "$GTK3SETTINGSPATH"
fi
if [ ! -f "$GTK4SETTINGSPATH" ]; then
	cp "$GTK4SETTINGSBAKPATH" "$GTK4SETTINGSPATH"
fi
