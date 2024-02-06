# Edit this configuration file to define what should be installed on

# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

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
            file.".config/hypr/hyprpaper.conf".text = ''
                preload = ~/.nixos/wallpaper.jpg
                wallpaper = ,~/.nixos/wallpaper.jpg
            '';
            sessionPath = [
                "/home/cam/go/bin/"
                "/home/cam/.system_node_modules/bin"
            ];
        };

        # Set Config File Locations
        xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
        xdg.configFile."waybar/config".source = ./waybar.conf;
        xdg.configFile."waybar/style.css".source = ./waybar.css;
        xdg.configFile."wofi/style.css".source = ./wofi.css;
        xdg.configFile."wofi/config".source = ./wofi.config;
        xdg.configFile."kitty/kitty.conf".source = ./kitty.conf;
        xdg.configFile."swaync/style.css".source = ./swaync.css;
        xdg.configFile."godot/text_editor_themes/godotTheme.tet".source = ./godotTheme.tet;

        # Global Dark Mode
        dconf.settings = {
            "org/gnome/desktop/interface" = {
                color-scheme = "prefer-dark";
            };
        };

        # Set Cursor Theme
        home.pointerCursor = {
            name = "Catppuccin-Mocha-Light-Cursors";
            package = pkgs.catppuccin-cursors.mochaLight;
        };

        # Set GTK App Theme
        gtk = {
            enable = true;
            cursorTheme = {
                name = "Catppuccin-Mocha-Light-Cursors";
                package = pkgs.catppuccin-cursors.mochaLight;
            };
            iconTheme = {
              name = "Adwaita";
              package = pkgs.gnome.adwaita-icon-theme;
            };
            theme = {
                name = "Catppuccin-Mocha-Standard-Blue-Dark";
                package = pkgs.catppuccin-gtk.override {
                    accents = [ "blue" ];
                    size = "standard";
                    variant = "mocha";
                    tweaks = [ "rimless" ];
                };
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

    # Faster Boot
    systemd.services.systemd-udev-settle.enable = false;
    systemd.services.NetworkManager-wait-online.enable = false;

    # Setup keyfile
    boot.initrd.secrets = {
        "/crypto_keyfile.bin" = null;
    };

    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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
    xdg.portal.wlr.enable = true;
    xdg.portal.extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-kde
    ];

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable a display manager.
    services.xserver.displayManager.gdm.enable = true;

    # Login manager
    services.xserver.displayManager.autoLogin.enable = true;
    services.xserver.displayManager.autoLogin.user = "cam";

    # Desktop environment
    # services.xserver.desktopManager.gnome.enable = true;
    programs.hyprland.enable = true;

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
        
        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
    };

    # Enable Power Saving Cpu Freq
    services.auto-cpufreq.enable = true;

    # Flatpak for other software you can't find on nixos
    services.flatpak.enable = true;

    # Enable hibernation. (You installed with swap right?)
    services.logind.lidSwitch = "hibernate";
    services.logind.extraConfig = ''
        HandleSuspendKey=hibernate
        HandlePowerKey=hibernate
        IdleAction=hibernate
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
    services.tailscale.enable = true;

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
        extraGroups = [ "networkmanager" "wheel" "input"];
        shell = pkgs.fish;
        packages = with pkgs; [
            # Desktop Software
            firefox
            xfce.thunar
            gimp
            inkscape
            libsForQt5.kdenlive
            blender
            libreoffice-fresh
            neovide
            qalculate-gtk
            anki-bin
            mpv
            obs-studio
            appimage-run

            # Terminal Commands
            zip # create .zip
            unzip # unzip .zip
            rar # create .rar
            unrar # unzip .rar
            rmtrash # trash when rm (needs alias)
            trash-cli # remove trash (autostart.sh)
            zoxide # better cd (needs setup)
            lf # file explorer

            # Hyprland Essentials
            waybar
            wofi
            playerctl
            brightnessctl
            hyprpaper
            udiskie
            swayidle
            shotman
            swaynotificationcenter
            libnotify                                                                        
            swayosd # manages volume and caps-lock notifications
            
            # Terminal
            kitty
            networkmanagerapplet                                                             
            polkit
            pavucontrol
            youtube-tui
            yt-dlp
            ffmpeg
            unsilence

            # QMK
            qmk

            # Gaming
            steam
            protonup-qt
            winetricks
            gamescope
            unstable.r2modman

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
            cargo
            cmake
            gnumake
            nasm
            jdk
            nodePackages.npm
            php
            raylib
            ruby
            wget
            dosbox
            steam-run
            pandoc
            openssl.dev
            pkg-config
            optipng
            jpegoptim

            # Languages
            dotnet-sdk
            flutter
            gcc
            go
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
        DOTNET_ROOT = "${pkgs.dotnet-sdk}";
        NODE_PATH = "~/.system_node_modules/lib/node_modules";
    };

    environment.gnome.excludePackages = [ pkgs.gnome-tour ];

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        # Game Software.
        unstable.bottles
        lutris

        # Shell
        fishPlugins.done
        fishPlugins.forgit
        fishPlugins.fzf-fish
        fishPlugins.grc
        fishPlugins.colored-man-pages
        fishPlugins.hydro

        # cli tools
        fzf
        grc
        pfetch
        sshfs

        # Clipboard
        wl-clipboard
        xclip

        # Razer
        openrazer-daemon
        polychromatic

        # Other
        android-tools
        android-studio

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
            alias rm="rmtrash"
            alias rmdir="rmdirtrash"
            zoxide init fish | source
            '';
        shellAbbrs = {
            add="git add";
            commit="git commit";
            pull="git pull";
            push="git push";
            clone="git clone";
            cd="z";
        };
    };
    programs.dconf.enable = true;
    programs.nix-ld.enable = true;
    programs.steam.remotePlay.openFirewall = true;

    # Battery
    powerManagement.powertop.enable = true;
    services.power-profiles-daemon.enable = true;

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
