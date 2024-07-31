{ pkgs, ... }:

{
    imports = [
        <home-manager/nixos>
    ];

    home-manager.useGlobalPkgs =true;
    home-manager.useUserPackages = true;
    home-manager.backupFileExtension = "hmbk";

    home-manager.users.cam = {
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
        # home.pointerCursor = {
        #     name = "Catppuccin-Mocha-Light-Cursors";
        #     package = pkgs.catppuccin-cursors.mochaLight;
        # };

        # Set GTK App Theme
        # gtk = {
        #     enable = true;
        #     # cursorTheme = {
        #     #     name = "Catppuccin-Mocha-Light-Cursors";
        #     #     package = pkgs.catppuccin-cursors.mochaLight;
        #     # };
        #     iconTheme = {
        #         name = "Breeze-Dark";
        #         package = pkgs.libsForQt5.breeze-icons;
        #     };
        #
        #     theme = {
        #         name = "Breeze-Dark";
        #         package = pkgs.libsForQt5.breeze-gtk;
        #     };
        #     # theme = {
        #     #     name = "Catppuccin-Mocha-Standard-Blue-Dark";
        #     #     package = pkgs.catppuccin-gtk.override {
        #     #         accents = [ "blue" ];
        #     #         size = "standard";
        #     #         variant = "mocha";
        #     #         tweaks = [ "rimless" ];
        #     #     };
        #     # };
        #
        #     gtk3.extraConfig = {
        #         Settings = ''
        #             gtk-application-prefer-dark-theme=1
        #             '';
        #     };
        #     gtk4.extraConfig = {
        #         Settings = ''
        #             gtk-application-prefer-dark-theme=1
        #             '';
        #     };
        # };

        # Set QT Theme (when on gnome)
        # qt = {
        #     enable = true;
        #     platformTheme = "gnome";
        #     style = {
        #         name = "adwaita-dark";
        #         package = pkgs.adwaita-qt;
        #     };
        # };

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
