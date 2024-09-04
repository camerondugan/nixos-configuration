{ pkgs, ... }:

{
    imports = [
        <catppuccin/modules/nixos>
        <home-manager/nixos>
    ];
    # enable catppuccin
    catppuccin.enable = true;
    catppuccin.flavor = "mocha";

    home-manager.useGlobalPkgs =true;
    home-manager.useUserPackages = true;
    home-manager.backupFileExtension = "hmbackup";

    home-manager.users.cam = {
        imports = [
            <catppuccin/modules/home-manager>
        ];
        home = {
            stateVersion = "23.05";
            sessionPath = [
                "/home/cam/go/bin/"
                "/home/cam/.cargo/bin/"
                "/home/cam/.go/bin/"
                "/home/cam/.go/current/bin/"
                "/home/cam/.system_node_modules/bin"
            ];
        };

        # Set Config File Locations
        xdg.configFile."kitty/kitty.conf".source =
            ./SoftwareBundles/CoderFiles/kitty.conf;
        xdg.configFile."godot/text_editor_themes/godotTheme.tet".source =
            ./SoftwareBundles/CoderFiles/godotTheme.tet;

        # Set Cursor Theme
        home.pointerCursor = {
            name = "Catppuccin-Mocha-Light-Cursors";
            package = pkgs.catppuccin-cursors.mochaLight;
            gtk.enable = true;
            x11.enable = true;
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
            theme = {
                name = "catppuccin-mocha-blue-standard";
                package = pkgs.catppuccin-gtk.override {
                    variant = "mocha";
                };
            };
            cursorTheme = {
                name = "catppuccin-mocha-light-cursors";
                package = pkgs.catppuccin-cursors.mochaLight;
            };
            iconTheme = {
              name = "Adwaita";
              # package = pkgs.adwaita-icon-theme;
              package = pkgs.gnome.adwaita-icon-theme;
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

        programs.neovim = {
            enable = true;
            defaultEditor = true;
            viAlias = true;
            vimAlias = true;
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
    };
}
