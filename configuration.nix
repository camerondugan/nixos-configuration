# Edit this configuration file to define what should be installed on

# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
            <home-manager/nixos>
            ./swap.nix
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
        };
        xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
        xdg.configFile."waybar/config".source = ./waybar.conf;
        xdg.configFile."waybar/style.css".source = ./waybar.css;
        xdg.configFile."wofi/style.css".source = ./wofi.css;
        xdg.configFile."wofi/config".source = ./wofi.config;
        xdg.configFile."kitty/kitty.conf".source = ./kitty.conf;

        home.pointerCursor = {
            name = "Catppuccin-Macchiato-Dark-Cursors";
            package = pkgs.catppuccin-cursors.macchiatoDark;
        };

        gtk = {
            enable = true;
            cursorTheme = {
                name = "Catppuccin-Macchiato-Dark-Cursors";
                package = pkgs.catppuccin-cursors.macchiatoDark;
            };
            iconTheme = {
              name = "Adwaita";
              package = pkgs.gnome.adwaita-icon-theme;
            };
            theme = {
                name = "Catppuccin-Macchiato-Standard-Blue-Dark";
                package = pkgs.catppuccin-gtk.override {
                    variant = "macchiato";
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
                pull.rebase = false;
            };
        };

        programs.neovim = {
            enable = true;
            defaultEditor = true;
            viAlias = true;
            vimAlias = true;
            # plugins = [
            #     pkgs.vimPlugins.packer-nvim
            # ];
        };
    };

    fonts.fonts = with pkgs; [
        nerdfonts
    ];
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Setup keyfile
    boot.initrd.secrets = {
        "/crypto_keyfile.bin" = null;
    };

    networking.hostName = "Linux"; # Define your hostname.
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
    xdg.portal = {
        enable = true;
        extraPortals = [
            pkgs.xdg-desktop-portal-hyprland
            pkgs.xdg-desktop-portal-gtk
        ];
    };

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.displayManager.autoLogin.enable = true;
    services.xserver.displayManager.autoLogin.user = "cam";
    # services.xserver.desktopManager.gnome.enable = true;

    # Configure keymap in X11
    services.xserver = {
        layout = "us";
        xkbVariant = "";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable mounting service.
    services.udisks2.enable = true;

    services.blueman.enable = true;

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
            appimage-run
            brave
            gimp
            inkscape
            blender
            libreoffice-fresh
            kitty
            wofi
            gnome.nautilus
            waybar
            hyprpaper
            dunst                                                                            
            udiskie
            swayidle
            shotman
            libnotify                                                                        
            networkmanagerapplet                                                             
            polkit
            pavucontrol

            # QMK
            qmk

            # Gaming
            discord
            steam
            # clonehero
            protonup-qt
            winetricks

            # Neovim extras
            bottom
            fd
            gdu
            julia-bin
            lazygit
            luajit
            luajitPackages.luarocks-nix
            neovide
            nodejs-slim
            php82Packages.composer
            ripgrep
            tree-sitter

            # Software Dev
            cargo
            cmake
            gnumake
            jdk
            nodePackages.npm
            php
            pkg-config
            raylib
            ruby
            unzip
            wget
            steam-run

            # Languages
            dotnet-sdk
            flutter
            gcc
            go
            pandoc
            rstudio
            rustup
            (rWrapper.override{ packages = with rPackages; [ggplot2 dplyr xts];})
            godot_4
            zig

            # VS Code
            (vscode-with-extensions.override {
                 vscodeExtensions = with vscode-extensions; [
                     bbenoist.nix
                     ionide.ionide-fsharp
                     ms-dotnettools.csharp
                     ms-python.python
                     ms-toolsai.jupyter
                     ms-vscode-remote.remote-ssh
                     vscodevim.vim
                 ];
             })
        ];
    };

    # Graphics support
    hardware.opengl.enable = true;
    hardware.opengl.driSupport = true;
    hardware.opengl.driSupport32Bit = true;
    hardware.pulseaudio.support32Bit = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    environment.sessionVariables = {
        DOTNET_ROOT = "${pkgs.dotnet-sdk}";
    };

    environment.gnome.excludePackages = [ pkgs.gnome-tour ];

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        # Game Software.
        bottles
        lutris
        # # Gnome Extensions.
        # gnomeExtensions.appindicator
        # gnomeExtensions.blur-my-shell
        # gnomeExtensions.caffeine
        # gnomeExtensions.dash-to-dock
        # gnomeExtensions.forge
        # gnomeExtensions.grand-theft-focus
        # gnomeExtensions.gsconnect
        # Shell
        fishPlugins.done
        fishPlugins.forgit
        fishPlugins.fzf-fish
        fishPlugins.grc
        fishPlugins.hydro
        fzf
        grc
        pfetch
        sshfs
        wl-clipboard
        xclip
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
        ]))];

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
            '';
    };
    programs.hyprland.enable = true;
    programs.dconf.enable = true;
    programs.nix-ld.enable = true;


    # Open ports in the firewall.
    networking.firewall.allowedTCPPortRanges = [ 
        { from = 1714; to = 1764; } # KDE Connect
    ];
    networking.firewall.allowedUDPPortRanges = [ 
        { from = 1714; to = 1764; } # KDE Connect
    ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?

    # Enable Auto Updates
    system.autoUpgrade.enable = true;
    system.autoUpgrade.allowReboot = false;

    # Enable Optimization.
    nix.gc.automatic = true;
    nix.gc.dates = "weekly";
    nix.gc.options = "--delete-older-than 7d";
    nix.optimise.automatic = true;
    nix.settings.auto-optimise-store = true;
}
