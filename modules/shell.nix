{
  flake.nixosModules.shell =
    { pkgs, ... }:
    {
      programs.fish.enable = true;
      users.users.cam.shell = pkgs.fish;
    };
}
