# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  lib,
  ...
}:
# let unstable = import <nixos-unstable> {config={allowUnfree=true;};};
#in
{
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Use desktop optimized kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  imports = [
    # DesktopEnvironments/gnome.nix
    # DesktopEnvironments/hyprland.nix
    DesktopEnvironments/cosmic.nix
    ./HardwareFixes/betterCaps.nix
    # Add the commented entries to ThisDevice/configuration.nix if this specific machine needs it.
    # gaming.nix
    # coding.nix
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Boot Graphics.
  boot.plymouth.enable = true;

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
        {
          from = 1714;
          to = 1764;
        } # kdeconnect
      ];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # kdeconnect
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
    settings.cue = true;
    # cue = true;
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
    extraGroups = ["networkmanager" "wheel" "input" "docker" "libvirtd" "kvm" "qemu-libvirtd"];
    shell = pkgs.fish;
    packages = with pkgs; [
      # Desktop Software
      firefox # Main Browser
      google-chrome # Backup Browser
      vesktop # Discord
      libreoffice # Office Suite
      papers # pdf
      image-roll # images
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
      comma # better temporary shell
      home-manager # manage home config
      neovim # Text editor
      direnv # needed for shell
    ];
  };

  hardware = {
    bluetooth.enable = true;
    # opengl.driSupport = true;
    # opengl.driSupport32Bit = true;
    graphics.enable = true;
    graphics.enable32Bit = true;
    graphics.extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
    graphics.extraPackages32 = with pkgs.pkgsi686Linux; [intel-vaapi-driver];
    enableAllFirmware = true;
  };

  environment.variables = {
    GOBIN = "~/go/bin";
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
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    pulseaudio.enable = false;

    # Auto Login
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

    # Speedup app launch for HDD
    # preload.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # Flatpak for other software you can't find on NixOS
    flatpak.enable = true;

    # List services that you want to enable:
    tailscale.enable = true;

    # Firmware Updater
    fwupd.enable = true;

    # Syncthing
    syncthing = {
      enable = true;
      user = "cam";
      dataDir = "/home/cam"; # wiki bad
      configDir = "/home/cam/.config/syncthing"; # my config better
    };

    # power-profiles-daemon.enable = true;
    upower.enable = true;

    # ollama
    ollama.enable = true;
    ollama.host = "0.0.0.0";
    # ollama.listenAddress = "0.0.0.0:11434";
  };
  powerManagement.enable = true;

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
    trusted-users = ["root" "cam"];
    experimental-features = ["nix-command" "flakes"];
  };
}
