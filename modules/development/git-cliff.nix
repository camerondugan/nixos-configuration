{
  flake.homeModules.git = {pkgs, ...}: {
    home.packages = with pkgs; [
      git-cliff
    ];
  };
}
