# Edit this configuration file to define what should be installed on

# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

let unstable = import <nixos-unstable> {config={allowUnfree=true;};};
in {

    imports = [
        ./hardware-configuration.nix
        <home-manager/nixos>
        ./this-device.nix
    ];

    home-manager = {
        useGlobalPkgs =true;
        useUserPackages = true;
    };

    home-manager.users.cam = {
        home = {
            stateVersion = "23.05";
            sessionPath = [
                "/home/cam/go/bin/"
                "/home/cam/.go/bin/"
                "/home/cam/.go/current/bin/"
                "/home/cam/.system_node_modules/bin"
            ];
        };

        # Set Config File Locations
        xdg.configFile."kitty/kitty.conf".source = ./kitty.conf;
        xdg.configFile."godot/text_editor_themes/godotTheme.tet".source = ./godotTheme.tet;

        # Set Cursor Theme
        # home.pointerCursor = {
        #     name = "Catppuccin-Mocha-Light-Cursors";
        #     package = pkgs.catppuccin-cursors.mochaLight;
        # };

        # Set GTK App Theme
        gtk = {
            enable = true;
            # cursorTheme = {
            #     name = "Catppuccin-Mocha-Light-Cursors";
            #     package = pkgs.catppuccin-cursors.mochaLight;
            # };
            iconTheme = {
                name = "Adwaita";
                package = pkgs.gnome.adwaita-icon-theme;
            };
            # theme = {
            #     name = "Catppuccin-Mocha-Standard-Blue-Dark";
            #     package = pkgs.catppuccin-gtk.override {
            #         accents = [ "blue" ];
            #         size = "standard";
            #         variant = "mocha";
            #         tweaks = [ "rimless" ];
            #     };
            # };
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
            platformTheme = "gnome";
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

        dconf.settings = {
            "org/gnome/desktop/interface" = {
                color-scheme = "prefer-dark";
                show-battery-percentage = true;
                clock-show-weekday = true;
                clock-show-date = true;
                clock-show-seconds = false;
                gtk-theme = "Adwaita-dark";
                font-hinting = "medium";
                font-antialiasing = "grayscale";
            };
            "org/gnome/desktop/sound" = {
                theme-name = "freedesktop";
            };
            "org/gnome/desktop/calendar" = {
                show-weekdate = false;
            };
            "org/gnome/desktop/background" = {
                picture-uri = "file:///home/cam/.nixos/wallpaper.jpg";
                picture-uri-dark = "file:///home/cam/.nixos/wallpaper.jpg";
                primary-color = "#000000000000";
                secondary-color = "#000000000000";
            };
            "org/gnome/desktop/screensaver" = {
                picture-uri = "file:///home/cam/.nixos/wallpaper.jpg";
                primary-color = "#000000000000";
                secondary-color = "#000000000000";
            };
            "org/gnome/desktop/privacy" = {
                remove-old-trash-files = true;
                remove-old-temp-files = true;
            };
            "org/gnome/desktop/media-handling" = {
            # Ask what to do instead of autorunning software from usb
                autorun-x-content-start-app = ["x-content/ostree-repository"];
                autorun-never = false;
            };
            "org/gnome/desktop/peripherals/touchpad" = {
                tap-to-click = true;
            };
            "org/gnome/desktop/peripherals/mouse" = {
                accel-profile = "flat";
            };
            "org/gnome/desktop/input-sources" = { 
                xkb-options = [#make caps ctrl
                    "terminate:ctr_alt_bksp"
                    "lv3:ralt_switch"
                    "caps:ctrl_modifier" 
                ];
            };
            "org/gnome/desktop/wm/preferences" = {
                focus-mode = "click"; #sloppy, mouse
                auto-raise = false;
                button-layout = "appmenu:minimize,maximize,close";
            };
            "org/gnome/desktop/wm/keybindings" = {
                toggle-fullscreen = ["<Super>f"];
                minimize = ["<Super>j"];
                close = ["<Super>c"];
                switch-to-workspace-left = ["<Super>h"];
                switch-to-workspace-right = ["<Super>l"];
                move-to-workspace-left = ["<Shift><Super>h"];
                move-to-workspace-right = ["<Shift><Super>l"];
                toggle-on-all-workspaces = ["<Super>p"];
                show-desktop = ["<Super>d"];
            };
            "org/gnome/mutter" = {
                dynamic-workspaces = true;
                edge-tiling = true;
                attach-modal-dialogs = false;
                center-new-windows = false;
                resize-with-right-button = true;
            };
            "org/gnome/settings-daemon/plugins/power" = {
                power-button-action = "hibernate";
            };
            "org/gnome/settings-daemon/plugins/media-keys" = {
                custom-keybindings = [
                    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
                        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
                        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
                ];
                www = ["<Super>w"];
                search = ["<Super>r"];
                calculator = ["<Super>m"]; #m = math
                    logout = ["<Super><Shift>m"];
                screensaver = "unset";
            };
            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
                binding = "<Super>t";
                command = "kitty";
                name = "Launch Terminal";
            };
            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
                binding = "<Super>n";
                # command = "neovide --multigrid --size 1500x1375";
                command = "kitty nvim";
                name = "Launch nvim in kitty";
            };
            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
                binding = "<Super>e";
                command = "nautilus";
                name = "Launch File Explorer";
            };
            "org/gnome/shell/keybindings" = {
                focus-active-notification = ["<Shift><Super>n"];
            };
            "org/gnome/shell" = {
                favorite-apps = ["firefox.desktop" "neovide.desktop" "anki.desktop" "org.gnome.Console.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Music.desktop" "gnome-system-monitor.desktop"];
                enabled-extensions = ["espresso@coadmunkee.github.com" "tiling-assistant@leleat-on-github" "rounded-window-corners@yilozt" "Rounded_Corners@lennart-k"];
                disabled-extensions = [];
            };
            "org/gnome/shell/extensions/espresso" = {
                show-notifications = false;
            };
        };
    };

    # Set Default Applications
    xdg.mime.defaultApplications = {
        "inode/directory" = "org.gnome.Nautilus.desktop";
    };

    fonts.packages = with pkgs; [
        nerdfonts
    ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # USB Keyboard/Mouse sleeping fix
    systemd.services.noUsbSleep = {
        enable = true;
        wantedBy = ["multi-user.target"];
        script = ''
            sleep 30
            echo on | tee /sys/bus/usb/devices/*/power/level > /dev/null
        '';
    };

    # Clightd Service... NixOS one is bonked
    systemd.services.clightd = {
        enable = true;
        wantedBy = ["multi-user.target"];
        script = ''
            ${pkgs.clightd}/bin/clightd
        '';
    };

    # Faster Boot
    systemd.services.systemd-udev-settle.enable = false;
    systemd.services.NetworkManager-wait-online.enable = false;

    # Setup keyfile
    boot.initrd.secrets = {
        "/crypto_keyfile.bin" = null;
    };

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "America/New_York";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    # XDG Setup
    # xdg.portal.wlr.enable = true;
    # xdg.portal.extraPortals = [
    #     pkgs.xdg-desktop-portal-gtk
    #     pkgs.xdg-desktop-portal-kde
    # ];

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable a display manager.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.displayManager.gdm.wayland = true;

    # Desktop environment
    services.xserver.desktopManager.gnome.enable = true;

    # # Login manager
    # services.xserver.displayManager.autoLogin.enable = true;
    # services.xserver.displayManager.autoLogin.user = "cam";

    # Configure keymap in X11
    services.xserver = {
        layout = "us";
        xkbVariant = "";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable mounting service.
    services.udisks2.enable = true;

    # Enable trash service.
    services.gvfs.enable = true;
    services.tumbler.enable = true;

    # Bluetooth
    services.blueman.enable = true;

    # Speedup App Launch
    services.preload.enable = true;

    # OpenRGB
    services.hardware.openrgb.enable = true;

    # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    hardware.bluetooth.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;
    };

    # Enable Power Saving Cpu Freq
    services.auto-cpufreq.enable = true;

    # Flatpak for other software you can't find on nixos
    services.flatpak.enable = true;

    # Enable hibernation. (You installed with swap right?)
    services.logind.lidSwitch = "hibernate"; # optionally hybrid-sleep (for saving to disk and sleeping)
    services.logind.extraConfig = ''
        HibernateDelaySec=15min
        HandleSuspendKey=suspend-then-hibernate
        HandleLidSwitch=suspend-then-hibernate
        IdleAction=suspend-then-hibernate
        HandlePowerKey=hibernate
    '';

    # Yubikey Optional Unlock
    security.pam.u2f = {
        enable = true;
        cue = true ;
    };
    security.pam.services = {
        login.u2fAuth = true;
        sudo.u2fAuth = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    services.xserver.libinput.enable = true;

    # List services that you want to enable:
    services = {
        tailscale.enable = true;
        geoclue2.enable = true;
    };

    # List Virtualisations you want to enable:
    virtualisation = {
        docker.enable = true;
    };

    # Syncthing
    services.syncthing = {
        enable = true;
        user = "cam";
        dataDir = "/home/cam/Sync";
        configDir = "/home/cam/Documents/.config/syncthing";
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.cam = {
        isNormalUser = true;
        description = "Cameron Dugan";
        extraGroups = [ "networkmanager" "wheel" "input" "docker" ];
        shell = pkgs.fish;
        packages = with pkgs; [
            # Desktop Software
            firefox
            libreoffice-fresh
            koreader
            gimp
            inkscape
            blender
            unstable.libsForQt5.kdenlive
            neovide
            anki
            obs-studio
            prusa-slicer
            appimage-run
            gnome-podcasts
            warp
            impression
            gnome-obfuscate
            eyedropper
            audacity

            # QMK
            qmk

            # Gaming
            steam
            protonup-qt
            winetricks
            gamescope
            unstable.r2modman
            unstable.bottles

            # Neovim extras
            bottom
            fd
            gdu
            julia-bin
            luajit
            luajitPackages.luarocks-nix
            nodejs-slim
            php82Packages.composer
            ripgrep
            tree-sitter
            plantuml
            imv
            feh

            # Software Dev
            lazygit
            gdb
            nasm
            jdk
            clang
            dosbox
            steam-run
            pandoc
            texlive.combined.scheme-medium
            optipng
            jpegoptim
            ntfy-sh
            gaphor

            # Languages
            dotnet-sdk
            flutter
            gcc
            unstable.go # go is always stable
            rstudio
            rustup
            godot_4
            zig
        ];
    };

    # Graphics support
    hardware.opengl.enable = true;
    hardware.opengl.driSupport = true;
    hardware.opengl.driSupport32Bit = true;
    hardware.pulseaudio.support32Bit = true;

    # Razer peripherals
    hardware.openrazer.enable = true;
    hardware.openrazer.users = ["cam"];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    environment.sessionVariables = {
        EDITOR = "nvim";
        GOBIN = "/home/cam/go/bin";
        VISUAL = "neovide";
        DOTNET_ROOT = "${pkgs.dotnet-sdk}";
        NODE_PATH = "~/.system_node_modules/lib/node_modules";
    };

    environment.gnome.excludePackages = [ 
        pkgs.gnome-tour 
        pkgs.gnome.gnome-software 
    ];

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [

        # GNOME
        gnome.gnome-sound-recorder

        # Shell
        fishPlugins.colored-man-pages
        fishPlugins.done
        fishPlugins.forgit
        fishPlugins.fzf
        fishPlugins.grc
        fishPlugins.pisces
        fishPlugins.puffer
        fishPlugins.sponge
        fishPlugins.z

        # Terminal Commands
        zip # create .zip
        unzip # unzip .zip
        rar # create .rar
        unrar # unzip .rar
        rmtrash # trash when rm (needs alias)
        zoxide # better cd (needs setup)
        lf # file explorer
        sl # Steam Locomotive
        mpv # View Media

        # Terminal
        kitty
        networkmanagerapplet
        polkit
        pavucontrol
        youtube-tui
        yt-dlp
        ffmpeg
        unsilence
        cargo
        cmake
        gnumake
        php
        nodePackages.npm
        wget
        ruby

        # cli tools
        fzf
        grc
        pfetch
        sshfs

        # Clipboard
        wl-clipboard
        wl-clip-persist
        xclip

        # Other
        android-tools
        android-studio

        # Auto Brightness
        clight
        clightd

        # Python
        (python311.withPackages(ps: with ps; [
            cairosvg
            jupyter-client
            pillow
            pip
            plotly
            pnglatex
            ueberzug
            pipx
            colorama
            pynvim
        ]))

        # Gnome Extensions
        gnomeExtensions.espresso
        gnomeExtensions.tiling-assistant
        gnomeExtensions.rounded-corners # monitor corners
        unstable.gnomeExtensions.rounded-window-corners
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # Program Configs
    programs.starship.enable = true;
    programs.fish = {
        enable = true;
        interactiveShellInit = ''
            pfetch
            set fish_greeting

            fish_vi_key_bindings
            bind --mode insert \cW 'fish_clipboard_copy' # disable ctrl+w
            bind --mode insert \b 'backward-kill-bigword' # rebind to ctrl+backspace

            alias rm="rmtrash"
            alias rmdir="rmdirtrash"
            alias sl="sl -ew"
            alias i="nix-shell -p"

            zoxide init fish | source
            '';
        shellAbbrs = {
            cd="z"; # force use z
            gi="gi >> .gitignore"; # append to gitignore
        };
    };
    programs.dconf.enable = true;
    programs.nix-ld.enable = true;
    programs.steam.remotePlay.openFirewall = true;

    # Battery
    powerManagement.powertop.enable = true;
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;

    # Kde Connect
    programs.kdeconnect.enable = true;
    networking.firewall.allowedTCPPortRanges = [ 
        { from = 1714; to = 1764; }
    ];
    networking.firewall.allowedUDPPortRanges = [ 
        { from = 1714; to = 1764; }
    ];

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?

    # Enable Auto Updates
    system.autoUpgrade = {
        enable = true;
        allowReboot = false;
    };

    # Enable Optimization.
    nix.gc.automatic = true;
    nix.gc.dates = "weekly";
    nix.gc.options = "--delete-older-than 7d";
    nix.optimise.automatic = true;
    nix.settings.auto-optimise-store = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
