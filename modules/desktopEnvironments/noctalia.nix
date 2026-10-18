{
  flake.nixosModules.noctalia = { pkgs, ... }: {
    services.displayManager.ly.enable = true;
    xdg.portal.wlr.enable = true;
    environment.systemPackages = with pkgs; [
      noctalia-shell
      alacritty
      fuzzel
      swaylock
      orca
      playerctl
      brightnessctl
      xwayland-satellite
    ];
    programs.niri.enable = true;
    programs.nm-applet.enable = true;
    networking.networkmanager.enable = true;
    hardware.bluetooth.enable = true;
    services = {
      # Bluetooth
      blueman.enable = true;
    };
  };
}
