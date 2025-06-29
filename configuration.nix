{
  pkgs,
  lib,
  ...
}: {
  nix = {
    settings = {
      substituters = [
        "https://cosmic.cachix.org/"
        "https://helix.cachix.org/"
      ];
      trusted-public-keys = [
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      ];
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  nixpkgs.config.allowUnfree = true;

  imports = [
    # ./nix-modules/desktop-environments/gnome.nix
    ./nix-modules/desktop-environments/hyprland.nix
    # ./nix-modules/desktop-environments/cosmic.nix
    ./nix-modules
    ./nix-modules/fixes/betterCaps.nix
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Boot Graphics.
  boot.plymouth.enable = true;

  time.timeZone = "America/New_York";

  networking = {
    # Enable networking
    networkmanager.enable = true;
    firewall = {
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDEConnect
      ];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDEConnect
      ];
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  security = {
    # Enable sound with pipe wire.
    rtkit.enable = true;

    # Yubikey Optional Unlock
    pam.u2f = {
      enable = true;
      settings.cue = true;
    };
    pam.services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
    };
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
      google-chrome # Browser
      discord # Calling
      libreoffice # Office Suite
      papers # pdf
      image-roll # images
      gimp # 2d Art
      prusa-slicer # 3d printer slicer
      warp # file transfer
      impression # ISO USB writer
      audacity # Audio Editor
      comma # better temporary shell
      home-manager # manage home config
      neovim # The best text editor (no bias)
      zellij # Tmux but newer
      direnv # environment by directory
    ];
  };

  hardware = {
    bluetooth.enable = true;
    graphics.enable = true;
    graphics.enable32Bit = true;
    enableAllFirmware = true;
  };

  services = {
    # Auto Login
    # displayManager.autoLogin.enable = true;
    # displayManager.autoLogin.user = "cam";

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    # Enable {}CUPS to print documents.
    printing.enable = true;
    # Auto discover printers
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
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

    # SyncThing
    syncthing = {
      enable = true;
      user = "cam";
      dataDir = "/home/cam"; # wiki bad
      configDir = "/home/cam/.config/syncthing"; # my config better
    };

    # power-profiles-daemon.enable = true;
    upower.enable = true;

    # AD Block + DNS
    # blocky.enable = true;
  };
  powerManagement.enable = true;

  # Kde Connect
  programs = {
    kdeconnect.enable = true;
    noisetorch.enable = true;
  };

  system = {
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix). Also remember to change home-manager's
    # version.
    stateVersion = "23.05"; # Did you read the comment?
  };

  # Enable Optimization.
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  nix.optimise.automatic = true;

  nix.settings = {
    trusted-users = ["root" "cam"];
    experimental-features = ["nix-command" "flakes"];
  };
}
