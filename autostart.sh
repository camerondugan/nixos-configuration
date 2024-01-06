#! /bin/sh

# Essential
waybar &
hyprpaper &
nm-applet &
blueman-applet &
udiskie &
swaync &
swayidle -w timeout 600 "hyprctl dispatcher dpms off" timeout 1200 "systemctl hibernate" resume "hyprctl dispatcher dpms on" &

# Razer Hardware
polychromatic-tray-applet &
# Pull Git repos
for repo in "/home/${USER}/.nixos" "/home/${USER}/.config/nvim" "/home/${USER}/.config/nvim/lua/user/"; do
	( (cd "$repo" && git pull) || notify-send "\~/.nixos/autostart.sh: $repo failed to pull or does not exist")
done
