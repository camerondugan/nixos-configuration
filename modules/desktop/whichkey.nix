{ ... }:
{
  flake.nixosModules.whichkey =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ wlr-which-key ];
    };
}
