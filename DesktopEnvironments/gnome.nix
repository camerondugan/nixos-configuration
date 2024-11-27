{pkgs, ...}: {
  services = {
    # Desktop environment (can't wait until cosmic)
    xserver.desktopManager.gnome.enable = true;
    # desktopManager.cosmic.enable = true;

    # Enable a display manager.
    xserver.displayManager.gdm.enable = true;
    # xserver.displayManager.gdm.wayland.enable = true;
    # displayManager.cosmic-greeter.enable = true;
  };

  # Set Default Applications
  xdg.mime.defaultApplications = {
    "inode/directory" = "org.gnome.Nautilus.desktop";
  };

  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    # GNOME
    gnome.gnome-boxes # boxes
    gnome.gnome-sound-recorder
    sushi
    polkit_gnome
    # Gnome Extensions
    gnomeExtensions.app-hider # add hide option to app menu
    gnomeExtensions.dash-to-dock # dock
    gnomeExtensions.blur-my-shell # better UI
    gnomeExtensions.burn-my-windows # better open/close animation
    gnomeExtensions.espresso # keeps screen on in full screen
    gnomeExtensions.pip-on-top # keeps Firefox pip above in Wayland
    gnomeExtensions.pop-shell # tiling windows
    gnomeExtensions.rounded-corners # monitor corners
    gnomeExtensions.tray-icons-reloaded # tray icons
  ];
}
