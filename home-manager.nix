{ pkgs, ... }:

let
    usr = "cam";
in 
    {
    # imports = [
    #     # <catppuccin/modules/nixos>
    #     <home-manager/nixos>
    # ];
    # enable catppuccin
    # catppuccin.enable = true;
    # catppuccin.flavor = "mocha";

    # home-manager.useGlobalPkgs =true;
    # home-manager.useUserPackages = true;
    # home-manager.backupFileExtension = "hmbackup";
    # home-manager.stateVersion = "23.05";

    # imports = [
    #     <catppuccin/modules/home-manager>
    # ];
    home = {
        username = "cam";
        homeDirectory = "/home/cam";
        stateVersion = "23.05";
        sessionPath = [
            "/home/${usr}/go/bin/"
            "/home/${usr}/.cargo/bin/"
            "/home/${usr}/.go/bin/"
            "/home/${usr}/.go/current/bin/"
            "/home/${usr}/.system_node_modules/bin"
        ];
    };

    # Set Config File Locations
    xdg.configFile."wezterm/wezterm.lua".source =
        ./SoftwareBundles/CoderFiles/wezterm.lua;
    xdg.configFile."godot/text_editor_themes/godotTheme.tet".source =
        ./SoftwareBundles/CoderFiles/godotTheme.tet;
    # Hyprland Config Files
    xdg.configFile."waybar/config".source = ./DesktopEnvironments/HyprlandFiles/waybar.conf;
    xdg.configFile."waybar/style.css".source = ./DesktopEnvironments/HyprlandFiles/waybar.css;
    xdg.configFile."wofi/style.css".source = ./DesktopEnvironments/HyprlandFiles/wofi.css;
    xdg.configFile."wofi/config".source = ./DesktopEnvironments/HyprlandFiles/wofi.conf;
    xdg.configFile."hypr/hyprland.conf".source = ./DesktopEnvironments/HyprlandFiles/hyprland.conf;
    xdg.configFile."hypr/hyprlock.conf".source = ./DesktopEnvironments/HyprlandFiles/hyprlock.conf;
    xdg.configFile."hypr/hypridle.conf".source = ./DesktopEnvironments/HyprlandFiles/hypridle.conf;
    xdg.configFile."wpaperd/config.toml".source = ./DesktopEnvironments/HyprlandFiles/wpaper.conf;
    xdg.configFile."hypr/hyprpaper.conf".text = ''
            preload = ~/.nixos/Assets/wallpaper.jpg
            wallpaper = ,~/.nixos/Assets/wallpaper.jpg
    '';

    # Set Cursor Theme
    home.pointerCursor = {
        name = "DMZ-White";
        package = pkgs.vanilla-dmz;
        gtk.enable = true;
        x11.enable = true;
        size = 24;
    };

    # Theme Setup
    # Set GTK App Theme
    dconf.enable = true;
    dconf.settings = {
        "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
        };
    };
    gtk = {
        enable = true;
    #     # theme = {
    #         # name = "catppuccin-mocha-blue-standard";
    #         # package = pkgs.catppuccin-gtk.override {
    #         #     variant = "mocha";
    #         # };
    #     # };
        cursorTheme = {
            name = "DMZ-White";
            package = pkgs.vanilla-dmz;
        };
    #     iconTheme = {
    #       name = "Adwaita";
    #       # package = pkgs.adwaita-icon-theme;
    #       package = pkgs.gnome.adwaita-icon-theme;
    #     };
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

    programs.git = {
        enable = true;
        userName = "Cameron Dugan";
        userEmail = "cameron.dugan@protonmail.com";
        lfs.enable = true;
        extraConfig = {
            core.editor = "vim";
            pull.rebase = false;
        };
    };

    programs.tmux = {
        enable = false;
        shortcut = "space";
        baseIndex = 1;
        keyMode = "vi";
        customPaneNavigationAndResize = true;
        escapeTime = 0;
        plugins = with pkgs.tmuxPlugins; [
            {
                plugin = resurrect;
                extraConfig = ''
                        set -g @resurrect-capture-pane-contents 'on'
                        set -g @resurrect-processes '"~nvim"'
                '';
            }
            {
                plugin = continuum;
                extraConfig = ''
                        set -g @continuum-restore 'on'
                        set -g @continuum-save-interval '5'
                '';
            }
        ];
        extraConfig = ''
                set -g mouse on
        '';
    };

    programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
            obs-backgroundremoval
            obs-3d-effect
            obs-scale-to-sound
            obs-composite-blur
        ];
    };
}
