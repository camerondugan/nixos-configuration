{
  flake.nixosModules.xfce = {
    # environment.systemPackages = with pkgs; [
    #   wl-clipboard-rs
    #   wayland-protocols
    # ];
    networking.networkmanager.enable = true;
    hardware.bluetooth.enable = true;
    services = {
      xserver.desktopManager.xfce.enable = true;
      xserver.enable = true;
      displayManager.defaultSession = "xfce";
      # Bluetooth
      blueman.enable = true;
      # Network
      # Sound
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };
    };
  };
}
