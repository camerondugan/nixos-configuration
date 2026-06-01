{ lib, ... }:
{
  flake.nixosModules.nix-settings = {
    nix.settings = {
      trusted-users = [
        "root"
        "cam"
      ];
    };
    nix.extraOptions = ''
      experimental-features = nix-command flakes
    '';
    nix.optimise.automatic = true;
    nix.gc = {
      automatic = lib.mkDefault true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };
}
