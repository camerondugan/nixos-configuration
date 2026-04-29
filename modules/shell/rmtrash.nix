{ pkgs, ... }:
{
  flake.nixosModules.rmtrash =
    { ... }:
    {
      environment.systemPackages = with pkgs; [ rmtrash ];

      programs.fish.shellAliases = {
        # force safer rm
        rm = "rmtrash";
        rmdir = "rmdirtrash";
      };
    };
}
