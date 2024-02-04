#! /bin/sh

# Essential
waybar &
hyprpaper &
nm-applet &
blueman-applet &
udiskie &
swaync &
swayidle -w timeout 600 "hyprctl dispatcher dpms off" timeout 1200 "systemctl hibernate" resume "hyprctl dispatcher dpms on" &
(yes | trash-empty 14) & # Empty trash more than 2 weeks old

# Remove week old downloads
find /home/cam/Downloads -mindepth 1 -mtime +7 -delete
mkdir /home/cam/Downloads/.stfolder

# Razer Hardware
polychromatic-tray-applet &

# This device only script for autostart (make sure it exists and is runnable)
touch /home/cam/.nixos/this-device-autostart.sh
chmod +x /home/cam/.nixos/this-device-autostart.sh
bash /home/cam/.nixos/this-device-autostart.sh &

# Pull Git repos
for repo in "/home/${USER}/.nixos" "/home/${USER}/.config/nvim" "/home/${USER}/.config/nvim/lua/user/"; do
	( (cd "$repo" && git pull) || notify-send "\~/.nixos/autostart.sh: $repo failed to pull or does not exist")
done
