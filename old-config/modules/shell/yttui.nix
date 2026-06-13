{...}: {
  flake.nixosModules.yttui = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      youtube-tui
      mpv # Required
    ];
  };
}
