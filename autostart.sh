#!/bin/sh
# ^^^^Rare thing happened here^^^^
# NTFY:
# ntfyLogin="$(cat /home/"$USER"/.nixos/ntfy.secret)"

# # Essential for window managers
# waybar &
# hyprpaper &
# udiskie &                          # auto mount usbs
# swaync &                           # notifs
# blueman-applet &                   # bluetooth man
# nm-applet &                        # network man
# wl-clip-persist --clipboard both & # remember clipboard after app closes
# swayidle -w \
# 	timeout 600 "hyprctl dispatcher dpms off" \
# 	timeout 1150 "ntfy pub -u $ntfyLogin ntfy.camerondugan.com/Desktop-Automations $hostname will shutdown due to inactivity!" \
# 	timeout 1200 "systemctl suspend-then-hibernate" \
# 	resume "sleep 1 && hyprctl dispatcher dpms on" &
# sway-audio-idle-inhibit &
# clight &
# (yes | trash-empty 14) & # Empty trash more than 2 weeks old

# # Razer Hardware
# polychromatic-tray-applet &

# Update flatpaks
flatpak update --noninteractive --assumeyes &

# Remove week old downloads
(
	find /home/cam/Downloads -mindepth 1 -mtime +7 -delete
	mkdir /home/cam/Downloads/.stfolder
) &

nixConf="/home/${USER}/.nixos"

# Pull Git repos
for repo in "$nixConf" "/home/${USER}/.config/nvim" "/home/${USER}/.config/nvim/lua/user/"; do
	( (cd "$repo" && git pull) || notify-send "$repo failed to pull or does not exist: .nixos/autostart.sh")
done

# Try to use the latest version of repo (just pulled from prev cmd)
( (cd "$nixConf" && ./test.sh && notify-send "Using latest config: .nixos/autostart.sh") || notify-send "Switch to new config failed or $nixConf does not exist: .nixos/autostart.sh")

# This device only script for auto start (make sure it exists and is run-able)
touch /home/cam/.nixos/this-device-autostart.sh
chmod +x /home/cam/.nixos/this-device-autostart.sh
bash /home/cam/.nixos/this-device-autostart.sh &
