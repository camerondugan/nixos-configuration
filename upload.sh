#!/usr/bin/env bash

arg1="$*" # all text after command
if [ -z "$arg1" ]; then
	echo "Please use \"./upload.sh description of changes\""
	exit 1
fi

# Switch
sudo nix-channel --update
if sudo nixos-rebuild switch --upgrade --fast --show-trace; then
	hyprctl reload
	git add . && git commit -m "$arg1" && git push
else
	# Build for next boot
	if sudo nixos-rebuild boot --upgrade --fast --show-trace; then
		hyprctl reload
		git add . && git commit -m "$arg1" && git push
	fi
fi
