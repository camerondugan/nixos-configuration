{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wofi # app launcher
    wezterm # terminal
    ghostty # backup term
    playerctl # media player shortcuts
    brightnessctl # screen brightness shortcuts
    pamixer # audio shortcuts
    swayosd # audio shortcut visuals
    wpaperd # wallpaper
    waybar # top bar
    # hyprnotify # notifications
    #wl-clip-persist # remember clipboard after app close
    grimblast # screenshot utility
    udiskie # auto-mount removable drives
    ianny # eyestrain prevention
    pavucontrol
    networkmanagerapplet
    nautilus # file manager
    seahorse # secret manager
    gnome-keyring # keyring
  ];

  programs = {
    hyprland.enable = true;
    hyprlock.enable = true;
    dconf.enable = true;
  };

  # Login Manager
  services.xserver.displayManager.gdm.enable = true;

  # kde connect
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk pkgs.kdePackages.xdg-desktop-portal-kde];
  programs.kdeconnect.enable = true;
  networking.firewall.interfaces.enp42s0.allowedUDPPortRanges = [
    {
      from = 1714;
      to = 1764;
    }
  ];
  networking.firewall.interfaces.enp42s0.allowedTCPPortRanges = [
    {
      from = 1714;
      to = 1764;
    }
  ];

  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true; # trash
  security.pam.services.cam.enableGnomeKeyring = true;
  security.pam.services.hyprland.enableGnomeKeyring = true;
  networking.networkmanager.enable = true;

  services = {
    pipewire.enable = true;
    pipewire.wireplumber.enable = true;
    hypridle.enable = true; # Screen lock and shutdown
    blueman.enable = true; # Bluetooth
    udisks2.enable = true; # Enable mounting service.
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.MOZ_ENABLE_WAYLAND = 1;

}
