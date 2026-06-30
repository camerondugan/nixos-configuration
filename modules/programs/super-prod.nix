{
  flake.homeModules.super-prod = {pkgs, ...}: {
    home.packages = with pkgs; [
      super-productivity
    ];
  };
}
