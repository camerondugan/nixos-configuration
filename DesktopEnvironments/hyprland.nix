{pkgs,...}:
{
    environment.systemPackages = with pkgs; [
        wofi
        playerctl
        brightnessctl
        pamixer
        hyprpaper
    ];
    programs = {
        hyprland.enable = true;
        waybar.enable = true;
        hyprlock.enable = true;
        dconf.enable = true;
    };
    services = {
        hypridle.enable = true;

        # Enable mounting service.
        udisks2.enable = true;

        # Enable trash service.
        gvfs.enable = true;
        tumbler.enable = true;
    };
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

        # Set GTK App Theme
        dconf.enable = true;
        dconf.settings = {
            "org/gnome/desktop/interface" = {
                color-scheme = "prefer-dark";
            };
        };
        gtk = {
            enable = true;
            catppuccin.enable = true;
            cursorTheme = {
                name = "catppuccin-mocha-light-cursors";
                package = pkgs.catppuccin-cursors.mochaLight;
            };
            iconTheme = {
              name = "Adwaita";
              package = pkgs.adwaita-icon-theme;
            };
            gtk3.extraConfig = {
                Settings = ''
                    gtk-application-prefer-dark-theme=1
                    '';
            };
            gtk4.extraConfig = {
                Settings = ''
                    gtk-application-prefer-dark-theme=1
                    '';
            };
        };

        # Set QT Theme
        qt = {
            enable = true;
            platformTheme.name = "adwaita";
            style = {
                name = "adwaita-dark";
                package = pkgs.adwaita-qt;
            };
        };
    };
}
