#! /bin/sh

# Essential
waybar &
hyprpaper &
udiskie &                          # auto mount usbs
swaync &                           # notifs
blueman-applet &                   # bluetooth man
nm-applet &                        # network man
wl-clip-persist --clipboard both & # remember clipboard after app closes
swayidle -w timeout 600 "hyprctl dispatcher dpms off" timeout 1200 "systemctl hibernate" resume "hyprctl dispatcher dpms on" &
(yes | trash-empty 14) & # Empty trash more than 2 weeks old

# Razer Hardware
polychromatic-tray-applet &

# Update flatpaks
yes | flatpak update &

# Remove week old downloads
find /home/cam/Downloads -mindepth 1 -mtime +7 -delete
mkdir /home/cam/Downloads/.stfolder

# This device only script for autostart (make sure it exists and is runnable)
touch /home/cam/.nixos/this-device-autostart.sh
chmod +x /home/cam/.nixos/this-device-autostart.sh
bash /home/cam/.nixos/this-device-autostart.sh &

# Pull Git repos
for repo in "/home/${USER}/.nixos" "/home/${USER}/.config/nvim" "/home/${USER}/.config/nvim/lua/user/"; do
	( (cd "$repo" && git pull) || notify-send "\~/.nixos/autostart.sh: $repo failed to pull or does not exist")
done
