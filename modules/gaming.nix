{
  flake.nixosModules.gaming =
    {
      pkgs,
      ...
    }:
    {
      programs = {
        steam = {
          enable = true;
          package = pkgs.steam.override {
            # ENABLE gamescope compatibility
            extraPkgs =
              pkgs': with pkgs'; [
                libXcursor
                libXi
                libXinerama
                libXScrnSaver
                libpng
                libpulseaudio
                libvorbis
                stdenv.cc.cc.lib # Provides libstdc++.so.6
                libkrb5
                keyutils
                # Add other libraries as needed
              ];
          };
          gamescopeSession.enable = true;
          remotePlay.openFirewall = true;
          dedicatedServer.openFirewall = true;
          # extraCompatPackages = with pkgs; [
            # proton-cachyos # Requires chaotic nix
          # ];
        };
        gamemode.enable = true;
      };

      environment.systemPackages = with pkgs; [
        # itch # not working currently in stable or unstable... # Game store
        # heroic
        # protonup-qt # Proton Downloader
        gamescope # View port emulation
        gamescope-wsi # HDR?
        gamemode
        dxvk
        # (bottles.override {removeWarningPopup = true;})
        # games
        # beyond-all-reason
      ];
    };
}
