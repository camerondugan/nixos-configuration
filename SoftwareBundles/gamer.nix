{ pkgs, ... }:
{
    programs.steam.enable = true;
    programs.steam.package = pkgs.steam.override {
        extraPkgs = pkgs:
            with pkgs; [ # x11 dependencies (more reliability)
                xorg.libXcursor
                xorg.libXi
                xorg.libXinerama
                xorg.libXScrnSaver
                libpng
                libpulseaudio
                libvorbis
                stdenv.cc.cc.lib
                libkrb5
                keyutils
        ];
    };
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
