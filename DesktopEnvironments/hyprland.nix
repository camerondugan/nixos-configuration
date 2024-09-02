{pkgs,...}:
{
    environment.systemPackages = with pkgs; [
        wofi # app launcher
        playerctl # media player shortcuts
        brightnessctl # screen brightness shortcuts
        pamixer # audio shortcuts
        swayosd # audio shortcut visuals
        hyprpaper # wallpaper
        # hyprnotify # notifications
        wl-clip-persist # remember clipboard after app close
        udiskie # auto-mount removable drives
        ianny # eyestrain prevention
        cosmic-files # file browsing
        brave # web browser (Firefox has a copy/paste bug)
    ];
    programs = {
        hyprland.enable = true;
        waybar.enable = true;
        hyprlock.enable = true;
        dconf.enable = true;
    };
    services.gnome.gnome-keyring.enable = true;
    networking.networkmanager.enable = true;
    services = {
        hypridle.enable = true; # Screen lock and shutdown
        blueman.enable = true; # Bluetooth
        udisks2.enable = true; # Enable mounting service.
    };

    # Config Files
    home-manager.users.cam = {
        xdg.configFile."hypr/hyprland.conf".source = ./HyprlandFiles/hyprland.conf;
        xdg.configFile."waybar/config".source = ./HyprlandFiles/waybar.conf;
        xdg.configFile."waybar/style.css".source = ./HyprlandFiles/waybar.css;
        xdg.configFile."wofi/style.css".source = ./HyprlandFiles/wofi.css;
        xdg.configFile."wofi/config".source = ./HyprlandFiles/wofi.conf;
        xdg.configFile."hypr/hyprpaper.conf".text = ''
            preload = ~/.nixos/Assets/wallpaper.jpg
            wallpaper = ,~/.nixos/Assets/wallpaper.jpg
            splash = true
        '';
    };
}
