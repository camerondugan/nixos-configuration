#! /bin/sh

# Essential
waybar &
hyprpaper &
nm-applet &
blueman-applet &
udiskie &
swayidle -w timeout 600 "hyprctl dispatcher dpms off" timeout 1200 "systemctl hibernate" &
# Razer Hardware
polychromatic-tray-applet &
# Pull Git repos
for repo in "/home/${USER}/.nixos" "/home/${USER}/.config/nvim" "/home/${USER}/.config/nvim/lua/user/"; do
	( (cd "$repo" && git pull) || notify-send "\~/.nixos/autostart.sh: $repo failed to pull or does not exist")
done
