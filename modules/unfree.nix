{
  flake.nixosModules.unfree = {
    nixpkgs.config.allowUnfree = true;
  };
}
