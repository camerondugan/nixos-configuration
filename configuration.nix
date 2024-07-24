# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, ... }:
# let unstable = import <nixos-unstable> {config={allowUnfree=true;};};
#in
{ 
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
    # Use desktop optimized kernel
    boot.kernelPackages = pkgs.linuxPackages_zen;
    services.cachix-agent.enable = true;

    imports = [
        /home/cam/.nixos/hardware-configuration.nix
        /home/cam/.nixos/this-device.nix
        # Add the commented entries to this-device.nix if this specific machine needs it.
        # ./gaming.nix 
        # ./coding.nix
        /home/cam/.nixos/home-manager.nix
    ];


    # Set Default Applications
    xdg.mime.defaultApplications = {
        "inode/directory" = "org.gnome.Nautilus.desktop";
    };

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
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    # Enable sound with pipe wire.
    # sound.enable = true;
    security.rtkit.enable = true;

    # Yubikey Optional Unlock
    security.pam.u2f = {
        enable = true;
        settings.cue = true ;
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
            webcord # Discord
            libreoffice-fresh # Office Suite
            koreader # Book Reader
            gimp # 2d Art
            inkscape # Vector Art
            blender # 3D Toolkit
            libsForQt5.kdenlive # Video Editor
            anki # Study Tool
            prusa-slicer # 3d printer slicer
            appimage-run # Run app image from terminal
            warp # file transfer
            impression # ISO USB writer
            eyedropper # Color Picker
            audacity # Audio Editor
        ];
    };

    hardware = {
        pulseaudio.enable = false;
        bluetooth.enable = true;
        # opengl.driSupport = true;
        # opengl.driSupport32Bit = true;
        graphics.enable = true;
        graphics.enable32Bit = true;
    };

    environment.variables = {
        EDITOR = "nvim";
        GOBIN = "/home/cam/go/bin";
        VISUAL = "neovide";
        DOTNET_ROOT = "${pkgs.dotnet-sdk}";
        NODE_PATH = "~/.system_node_modules/lib/node_modules";
        NIXPKGS_ALLOW_UNFREE = 1;
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        # Clipboard
        # wl-clipboard
        # wl-clip-persist
        xclip

        # Auto Brightness
        clight
        clightd
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    programs.dconf.enable = true;
    programs.nix-ld.enable = true;
    programs.fish.enable = true;

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
        # desktopManager.plasma6.enable = true;
        desktopManager.cosmic.enable = true;

        # Enable a display manager.
        # displayManager.sddm.enable = true;
        # displayManager.sddm.wayland.enable = true;
        displayManager.cosmic-greeter.enable = true;


        # Login manager
        displayManager.autoLogin.enable = true;
        displayManager.autoLogin.user = "cam";

        # Enable touchpad support (enabled default in most desktopManager).
        libinput.enable = true;

        # Enable CUPS to print documents.
        printing.enable = true;

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
        };

        # Energy Saving
        power-profiles-daemon.enable = true;
        upower.enable = true;

        # ollama
        ollama.enable = true;
        # ollama.listenAddress = "0.0.0.0:11434";
        ollama.host = "0.0.0.0";
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
