{
  flake.nixosModules.fingerprint = {
    services.fprintd.enable = true;
  };
}
