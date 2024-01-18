#!/bin/sh
# Switch
sudo nix-channel --update
if sudo nixos-rebuild switch --upgrade --fast; then
	hyprctl reload
	git add . && git commit -m 'upload after build' && git push
else
	# Build for next boot
	if sudo nixos-rebuild boot --upgrade --fast; then
		hyprctl reload
		git add . && git commit -m 'upload after build' && git push
	fi
fi
