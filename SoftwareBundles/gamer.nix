{pkgs, ...}: {
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.steam.remotePlay.openFirewall = true;
  programs.steam.dedicatedServer.openFirewall = true;
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    # itch # not working currently in stable or unstable... # Game store
    protonup-qt # Proton Downloader
    gamescope # View port emulation
    bottles # Runs Windows Games
  ];
}
