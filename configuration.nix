# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];
  
  home-manager.users.cam = {
    home.stateVersion = "23.05";
    programs.git = {
      enable = true;
      userName = "Cameron Dugan";
      userEmail = "cameron.dugan@protonmail.com";
    };
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
	show-battery-percentage = true;
      };
      "org/gnome/mutter" = {
        dynamic-workspaces = true;
      };
      "org/gnome/desktop/peripherals/touchpad" = {
	tap-to-click = true;
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>t";
	command = "kgx";
	name = "Launch Terminal";
      };
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-0901906b-019c-4d9c-aaf1-5a0a4eaf7ea3".device = "/dev/disk/by-uuid/0901906b-019c-4d9c-aaf1-5a0a4eaf7ea3";
  boot.initrd.luks.devices."luks-0901906b-019c-4d9c-aaf1-5a0a4eaf7ea3".keyFile = "/crypto_keyfile.bin";

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
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

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cam = {
    isNormalUser = true;
    description = "Cameron Dugan";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [

      # Desktop Software
      brave
      obsidian
      libreoffice-fresh
      zoom-us

      # Gaming
      heroic
      steam
      discord
      wineWowPackages.stable
      winetricks

      # Neovim dependencies.
      fd
      ripgrep
      luajit
      luajitPackages.luarocks-nix
      php82Packages.composer
      php
      nodePackages.npm
      jdk
      nodejs-slim
      cargo
      julia-bin
      unzip
      wget

      # Developer Software.

      # VS Code
      (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
          bbenoist.nix
          ms-python.python
          ms-vscode-remote.remote-ssh
	  vscodevim.vim
	  ms-toolsai.jupyter
        ];
      })


      # Languages
      go
      rustup
      zig
      dotnet-sdk
      rstudio
    ];
  };

  # 32 Bit Opengl (for older software)
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.enable = true;
  hardware.pulseaudio.support32Bit = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     # Game Software.
     lutris
     bottles
     # Gnome Extensions.
     gnomeExtensions.forge
     gnomeExtensions.dash-to-dock
     gnomeExtensions.blur-my-shell
     gnomeExtensions.caffeine
     gnomeExtensions.appindicator
     # Shell
     pfetch
     fishPlugins.done
     fishPlugins.fzf-fish
     fishPlugins.forgit
     fishPlugins.hydro
     fzf
     fishPlugins.grc
     grc
     # Other
     android-tools
     # Python
     (python311.withPackages(ps: with ps; [
       pip
       jupyter-client
       ueberzug
       pillow
       cairosvg
       pnglatex
       plotly
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
  programs.neovim = {
	  enable = true;
	  viAlias = true;
	  vimAlias = true;
  };

  # List services that you want to enable:
  services.tailscale.enable = true;
  programs.starship.enable = true;
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      pfetch
      set fish_greeting
      fish_vi_key_bindings
    '';
  };

  # Syncthing
  services.syncthing = {
	  enable = true;
	  user = "cam";
	  dataDir = "/home/cam/Sync";
	  configDir = "/home/cam/Documents/.config/syncthing";
  };


  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
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
  nix.settings.auto-optimise-store = true;
}
