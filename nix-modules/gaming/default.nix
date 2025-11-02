{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    gaming.enable = lib.mkEnableOption "enables gaming software";
  };
  config = lib.mkIf config.gaming.enable {
    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
      };
      gamemode.enable = true;
    };

    environment.systemPackages = with pkgs; [
      # itch # not working currently in stable or unstable... # Game store
      heroic
      # protonup-qt # Proton Downloader
      gamescope # View port emulation
      bottles.override {
        removeWarningPopup = true;
      } # Runs Windows Games
    ];
  };
}
