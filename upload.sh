#!/bin/sh

arg1="$*" # all text after command
if [ -z "$arg1" ]; then
	exit 1
fi

# Switch
sudo nix-channel --update
if sudo nixos-rebuild switch --upgrade --fast; then
	hyprctl reload
	git add . && git commit -m "$arg1" && git push
else
	# Build for next boot
	if sudo nixos-rebuild boot --upgrade --fast; then
		hyprctl reload
		git add . && git commit -m "$arg1" && git push
	fi
fi
