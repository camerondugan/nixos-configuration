#!/bin/sh
# Switch
if sudo nixos-rebuild switch --upgrade-all; then
	hyprctl reload
	git add . && git commit -m 'upload after build' && git push
else
	# Build for next boot
	if sudo nixos-rebuild boot --upgrade-all; then
		hyprctl reload
		git add . && git commit -m 'upload after build' && git push
	fi
fi
