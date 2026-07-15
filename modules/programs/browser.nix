{
  flake.nixosModules.browser = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      brave
    ];
  };
}
