{pkgs, ...}: {
  imports = [
    <home-manager/nixos>
  ];
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };
  # Give KDE rounded corners if enabled?
  environment.systemPackages = with pkgs; [
    kde-rounded-corners
  ];
}
