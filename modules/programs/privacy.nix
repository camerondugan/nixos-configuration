{
  flake.homeModules.privacy = {pkgs, ...}: {
    home.packages = with pkgs; [
      tor-browser
    ];
  };
}
