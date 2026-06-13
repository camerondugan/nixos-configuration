{
  flake.nixosModules.anki = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      anki
    ];
  };
}
