{
  perSystem =
    {
      config,
      self',
      inputs',
      pkgs,
      system,
      ...
    }:
    {
      # Per-system attributes can be defined here. The self' and inputs'
      # module parameters provide easy access to attributes of the same
      # system.

      # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
      packages.default = pkgs.hello;
    };
  flake =
    {
      # The usual flake attributes can be defined here, including system-
      # agnostic ones like nixosModule and system-enumerating ones, although
      # those are more easily expressed in perSystem.
    };
}
