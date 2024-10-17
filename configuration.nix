# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, lib, ... }:
# let unstable = import <nixos-unstable> {config={allowUnfree=true;};};
#in
{ 
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
    # Use desktop optimized kernel
    boot.kernelPackages = pkgs.linuxPackages_zen;

    imports = [
        ./hardware-configuration.nix
        ./home-manager.nix
        ./ThisDevice/configuration.nix
        ./DesktopEnvironments/hyprland.nix
        # Add the commented entries to ThisDevice/configuration.nix if this specific machine needs it.
        # ./gaming.nix 
        # ./coding.nix
    ];

    fonts.packages = with pkgs; [
        ( nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

    # Bootloader.
    boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
    };

    systemd.services = {
        # # Clightd NixOS one is bonked, no idea how to make it work
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
    };

    networking = {
        # Enable networking
        networkmanager.enable = true;
        firewall = {
            # allowedTCPPorts = [ 11434 ]; # ollama
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
        # LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        # LC_TIME = "en_US.UTF-8";
    };

    # Enable sound with pipe wire.
    # sound.enable = true;
    security.rtkit.enable = true;

    # Yubikey Optional Unlock
    security.pam.u2f = {
        enable = true;
        # settings.cue = true ;
        cue = true ;
    };
    security.pam.services = {
        login.u2fAuth = true;
        sudo.u2fAuth = true;
    };

    virtualisation = {
        docker.enable = true;
    };

    # Define a user account.
    users.users.cam = {
        isNormalUser = true;
        description = "Cameron Dugan";
        extraGroups = [ "networkmanager" "wheel" "input" "docker" "libvirtd" "kvm" "qemu-libvirtd" ];
        shell = pkgs.fish;
        packages = with pkgs; [
            # Desktop Software
            google-chrome # Browser
            libreoffice-fresh # Office Suite
            koreader # Book Reader
            gimp # 2d Art
            inkscape # Vector Art
            webcord # Discord
            blender # 3D Toolkit
            libsForQt5.kdenlive # Video Editor
            anki # Study Tool
            prusa-slicer # 3d printer slicer
            appimage-run # Run app image from terminal
            warp # file transfer
            impression # ISO USB writer
            eyedropper # Color Picker
            audacity # Audio Editor
            comma # better temporary shell
        ];
    };

    hardware = {
        pulseaudio.enable = false;
        bluetooth.enable = true;
        opengl.driSupport = true;
        opengl.driSupport32Bit = true;
        # graphics.enable = true;
        # graphics.enable32Bit = true;
    };

    environment.variables = {
        EDITOR = "nvim";
        GOBIN = "/home/cam/go/bin";
        VISUAL = "neovide";
        DOTNET_ROOT = "${pkgs.dotnet-sdk}";
        NODE_PATH = "~/.system_node_modules/lib/node_modules";
        NIXPKGS_ALLOW_UNFREE = 1;
    };

    environment.systemPackages = with pkgs; [
        # Clipboard
        # wl-clipboard
        # wl-clip-persist
        xclip

        # Auto Brightness
        clight
        clightd
    ];

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

        # Login manager
        displayManager.autoLogin.enable = true;
        displayManager.autoLogin.user = "cam";

        # Enable touchpad support (enabled default in most desktopManager).
        libinput.enable = true;

        # Enable CUPS to print documents.
        printing.enable = true;
        # Auto discover printers
        avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };


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
            dataDir = "/home/cam"; # wiki bad
            configDir = "/home/cam/.config/syncthing"; # my config better
        };

        # Energy Saving
        power-profiles-daemon.enable = true;
        upower.enable = true;

        # ollama
        ollama.enable = true;
        # ollama.host = "0.0.0.0";
        ollama.listenAddress = "0.0.0.0:11434";
    };

    # Kde Connect
    programs.kdeconnect.enable = true;

    programs.noisetorch.enable = true;

    system = {
        # Before changing this value read the documentation for this option
        # (e.g. man configuration.nix). Also remember to change home-manager's
        # version.
        stateVersion = "23.05"; # Did you read the comment?

        # Enable Auto Updates
        # autoUpgrade = {
        #     enable = true;
        #     allowReboot = false;
        # };
    };

    # Enable Optimization.
    nix.gc = {
        automatic = lib.mkDefault true;
        dates = "daily";
        options = "--delete-older-than 3d";
    };
    nix.optimise.automatic = true;
    nix.settings = {
        trusted-users = [ "root" "cam" ];
        experimental-features = [ "nix-command" "flakes" ];
    };
}
