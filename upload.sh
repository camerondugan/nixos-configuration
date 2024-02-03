#!/bin/sh

arg1="$*"
echo "$arg1"
if [ -z "$arg1" ]; then
	arg1="upload.sh"
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
