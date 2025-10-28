{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      fuzzel # Stupid fast wayland app launcher
      nwg-dock-hyprland # dock
      wezterm # terminal
      kitty # backup term
      playerctl # media player shortcuts
      brightnessctl # screen brightness shortcuts
      pamixer # audio shortcuts
      swaynotificationcenter # notifications
      swayosd # audio shortcut visuals
      wpaperd # wallpaper
      waybar # top bar
      # hyprnotify # notifications
      wl-clip-persist # remember clipboard after app close
      wl-clipboard-rs
      grimblast # screenshot utility
      udiskie # auto-mount removable drives
      # pavucontrol
      networkmanagerapplet
      nautilus # file manager
      seahorse # secret manager
      gnome-keyring # keyring
      hyprls # lsp for config editors
      bluetui # tui for bluetooth control
      pulsemixer # tui that replaces pavucontrol
      sunsetr
      hyprsunset
    ];

    sessionVariables.NIXOS_OZONE_WL = "1";
    sessionVariables.MOZ_ENABLE_WAYLAND = 1;
  };

  programs = {
    hyprland.enable = true;
    hyprlock.enable = true;
    dconf.enable = true;
  };

  services = {
    # Login Manager
    displayManager.ly.enable = true;

    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;

    pipewire.enable = true;
    pipewire.wireplumber.enable = true;
    hypridle.enable = true; # Screen lock and shutdown
    blueman.enable = true; # Bluetooth
    udisks2.enable = true; # Enable mounting service.
  };

  # KDE connect
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.kdePackages.xdg-desktop-portal-kde
  ];
  networking.firewall.interfaces.enp42s0 = {
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  }; # trash
  security.pam.services.cam.enableGnomeKeyring = true;
  security.pam.services.hyprland.enableGnomeKeyring = true;
  networking.networkmanager.enable = true;
}
