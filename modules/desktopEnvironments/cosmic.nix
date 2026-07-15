{
  flake.nixosModules.cosmic = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      wl-clipboard-rs
    ];
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;
    environment.cosmic.excludePackages = with pkgs; [
      cosmic-edit
      cosmic-term
      cosmic-player
    ];
    services.system76-scheduler.enable = true;

    # unsure
    xdg.portal.enable = true;
    xdg.portal.wlr.enable = true;
  };
}
