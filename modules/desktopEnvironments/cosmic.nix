{
  flake.nixosModules.cosmic = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      wl-clipboard-rs
    ];
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;
    services.system76-scheduler.enable = false;
  };
}
