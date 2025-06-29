{pkgs, lib, config, ...}: {
  options = {
    gamer.enable = lib.mkEnableOption "enables gamer software";
  };
  config = lib.mkIf config.gamer.enable {
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
      protonup-qt # Proton Downloader
      gamescope # View port emulation
      bottles # Runs Windows Games
    ];
  };
}
