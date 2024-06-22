# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

# let unstable = import <nixos-unstable> {config={allowUnfree=true;};};
#in
{ 
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    imports = [
        ./hardware-configuration.nix
        ./this-device.nix
        # Remove below entries if you don't want/need them
        ./home-manager.nix
        ./coder.nix
    ];

    # Set Default Applications
    xdg.mime.defaultApplications = {
        "inode/directory" = "org.gnome.Nautilus.desktop";
    };

    fonts.packages = with pkgs; [
        jetbrains-mono
    ];

    # Bootloader.
    boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
    };

    systemd.services = {
        # TODO: Move these to this-device config
        # # USB Keyboard/Mouse sleeping fix
        # noUsbSleep = {
        #     enable = true;
        #     wantedBy = ["multi-user.target"];
        #     script = ''
        #         sleep 30
        #         echo on | tee /sys/bus/usb/devices/*/power/level > /dev/null
        #     '';
        # };

        # # Clightd Service... NixOS one is bonked
        # clightd = {
        #     enable = true;
        #     wantedBy = ["multi-user.target"];
        #     script = ''
        #         ${pkgs.clightd}/bin/clightd
        #     '';
        # };

        autoStartScript = {
            enable = true;
            wantedBy = ["default.target"];
            script = ''
                ./home/cam/.nixos/autostart.sh
            '';
        };

        # Faster Boot
        systemd-udev-settle.enable = false;
        NetworkManager-wait-online.enable = false;
    };

    # Setup keyfile
    boot.initrd.secrets = {
        "/crypto_keyfile.bin" = null;
    };

    networking = {
        # Enable networking
        networkmanager.enable = true;
        firewall = {
            allowedTCPPortRanges = [
                { from = 1714; to = 1764; } # kdeconnect
            ];
            allowedUDPPortRanges = [
                { from = 1714; to = 1764; } # kdeconnect
            ];
        };
    };

    # Set your time zone.
    time.timeZone = "America/New_York";

    # Select internationalization properties.
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

    # Enable sound with pipe wire.
    sound.enable = true;
    security.rtkit.enable = true;

    # Yubikey Optional Unlock
    security.pam.u2f = {
        enable = true;
        cue = true ;
    };
    security.pam.services = {
        login.u2fAuth = true;
        sudo.u2fAuth = true;
    };

    virtualisation = {
        docker.enable = true;
        libvirtd = {
          enable = true;
          qemu = {
            package = pkgs.qemu_kvm;
            runAsRoot = true;
            swtpm.enable = true;
            ovmf = {
              enable = true;
              packages = [(pkgs.OVMF.override {
                secureBoot = true;
                tpmSupport = true;
              }).fd];
            };
          };
        };
    };

    # Define a user account.
    users.users.cam = {
        isNormalUser = true;
        description = "Cameron Dugan";
        extraGroups = [ "networkmanager" "wheel" "input" "docker" "libvirtd" "kvm" "qemu-libvirtd" ];
        shell = pkgs.fish;
        packages = with pkgs; [
            # Desktop Software
            firefox # Browser
            beeper # Chat
            webcord # Discord
            libreoffice-fresh # Office Suite
            koreader # Book Reader
            gimp # 2d Art
            inkscape # Vector Art
            blender # 3D Toolkit
            libsForQt5.kdenlive # Video Editor
            neovide # nvim GUI
            anki # Study Tool
            prusa-slicer # 3d printer slicer
            appimage-run # Run app image from terminal
            warp # file transfer
            impression # ISO USB writer
            eyedropper # Color Picker
            audacity # Audio Editor
            freecad # 3D modeler

            # Gaming
            #itch # not working currently in 24.5... Game Store
            protonup-qt # Proton Downloader
            gamescope # View port emulation
            # gnome.gnome-boxes # boxes
            bottles # Runs Windows Games

            # Software Dev Tools
            direnv
            devenv
            kitty
            tmux
            lazygit
            ripgrep
            httplz
            plantuml
            fd
            gdb
            nasm
            steam-run
            pandoc
            texlive.combined.scheme-medium
            optipng
            jpegoptim
            ntfy-sh
            bottom
            gdu
            luajit
            luajitPackages.luarocks-nix
            nodejs-slim
            php82Packages.composer
            tree-sitter
            imv
            feh

            # Languages (no particular order)
            dotnet-sdk
            flutter
            gcc
            go
            rstudio
            rustup
            godot_4
            zig
            jdk
            clang
            julia-bin
        ];
    };

    hardware = {
        pulseaudio.enable = false;
        bluetooth.enable = true; # only for de that doesn't include

        # Graphics support
        opengl.enable = true;
        opengl.driSupport = true;
        opengl.driSupport32Bit = true;
        pulseaudio.support32Bit = true;
    };

    environment.sessionVariables = {
        EDITOR = "nvim";
        GOBIN = "/home/cam/go/bin";
        VISUAL = "neovide";
        DOTNET_ROOT = "${pkgs.dotnet-sdk}";
        NODE_PATH = "~/.system_node_modules/lib/node_modules";
    };

    # environment.gnome.excludePackages = [ 
    #     pkgs.gnome-tour 
    #     pkgs.gnome.gnome-software 
    # ];

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        # # GNOME
        # gnome.gnome-sound-recorder
        # gnome.sushi
        # polkit_gnome

        # Clipboard
        # wl-clipboard
        # wl-clip-persist
        xclip

        # Auto Brightness
        clight
        clightd

        # Python
        (python311.withPackages(ps: with ps; [
            pip
            pynvim
        ]))

        # Gnome Extensions
        # gnomeExtensions.app-hider # add hide option to app menu
        # gnomeExtensions.dash-to-dock # dock
        # gnomeExtensions.blur-my-shell # better ui
        # gnomeExtensions.burn-my-windows # better open/close animation
        # gnomeExtensions.espresso # keeps screen on in full screen
        # gnomeExtensions.pip-on-top # keeps Firefox pip above in Wayland
        # gnomeExtensions.pop-shell # tiling windows
        # gnomeExtensions.rounded-corners # monitor corners
        # gnomeExtensions.tray-icons-reloaded # tray icons
    ];


    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
    programs.dconf.enable = true;
    programs.nix-ld.enable = true;

    programs.steam.enable = true;
    programs.steam.package = pkgs.steam.override {
        extraPkgs = pkgs:
            with pkgs; [ # x11 dependencies
                xorg.libXcursor
                xorg.libXi
                xorg.libXinerama
                xorg.libXScrnSaver
                libpng
                libpulseaudio
                libvorbis
                stdenv.cc.cc.lib
                libkrb5
                keyutils
        ];
    };
    programs.steam.gamescopeSession.enable = true;
    programs.steam.remotePlay.openFirewall = true;
    programs.steam.dedicatedServer.openFirewall = true;


    services = {
        xserver = {
                # Enable the X11 windowing system.
                enable = true;

                # Configure keymap in X11
                xkb= {
                    layout = "us";
                    variant = "";
                };
        };

        # Desktop environment (can't wait until cosmic)
        desktopManager.plasma6.enable = true;

        # Enable a display manager.
        displayManager.sddm.enable = true;
        displayManager.sddm.wayland.enable = true;


        # Login manager
        displayManager.autoLogin.enable = true;
        displayManager.autoLogin.user = "cam";

        # Enable touchpad support (enabled default in most desktopManager).
        libinput.enable = true;

        # Enable CUPS to print documents.
        printing.enable = true;

        # Enable mounting service.
        udisks2.enable = true;

        # Enable trash service.
        gvfs.enable = true;
        tumbler.enable = true;

        # Bluetooth (for when no bluetooth ui provided)
        # blueman.enable = true;

        # Speedup App Launch
        preload.enable = true;

        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;
        };

        # Flatpak for other software you can't find on NixOS
        flatpak.enable = true;

        # Enable hibernation with no DE. (You installed with swap right?)
        logind.extraConfig = ''
            HibernateDelaySec=15min
            HandleSuspendKey=hibernate
            HandleLidSwitch=hibernate
            IdleAction=hibernate
        '';

        # List services that you want to enable:
        tailscale.enable = true;
        geoclue2.enable = true;

        # Firmware Updater
        fwupd.enable = true;

        # Syncthing
        syncthing = {
            enable = true;
            user = "cam";
            dataDir = "/home/cam/Sync";
            configDir = "/home/cam/Documents/.config/syncthing";
        };

        # Energy Saving
        power-profiles-daemon.enable = true;
        upower.enable = true;
        auto-cpufreq.enable = true;

        # ollama
        ollama.enable = true;
    };

    # Kde Connect
    programs.kdeconnect.enable = true;
    system = {

        # Before changing this value read the documentation for this option
        # (e.g. man configuration.nix). Also remember to change home-manager's
        # version.

        stateVersion = "23.05"; # Did you read the comment?

        # Enable Auto Updates
        autoUpgrade = {
            enable = true;
            allowReboot = false;
        };
    };

    # Enable Optimization.
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };
    nix.optimise.automatic = true;
    nix.settings = {
        trusted-users = [ "root" "cam" ];
        auto-optimise-store = true;
        experimental-features = [ "nix-command" "flakes" ];
    };
}
