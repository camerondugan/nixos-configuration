{pkgs, ...}: {
  services = {
    # Desktop environment (can't wait until cosmic)
    xserver.desktopManager.gnome.enable = true;
    # desktopManager.cosmic.enable = true;

    # Enable a display manager.
    displayManager.gdm.enable = true;
    # displayManager.cosmic-greeter.enable = true;
  };

  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    # GNOME
    gnome-boxes # boxes
    gnome-sound-recorder
    sushi
    polkit_gnome
    gnome-tweaks
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
