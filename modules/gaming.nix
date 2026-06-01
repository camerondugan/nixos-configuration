{
  flake.nixosModules.gaming =
    {
      pkgs,
      lib,
      ...
    }:
    {
      nixpkgs.config.allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "steam"
          "steam-unwrapped"
        ];
      programs = {
        steam = {
          enable = true;
          gamescopeSession.enable = true;
          remotePlay.openFirewall = true;
          dedicatedServer.openFirewall = true;
          extraCompatPackages = with pkgs; [
            proton-cachyos # Requires chaotic nix
          ];
        };
        gamemode.enable = true;
      };

      environment.systemPackages = with pkgs; [
        # itch # not working currently in stable or unstable... # Game store
        # heroic
        # protonup-qt # Proton Downloader
        gamescope # View port emulation
        gamemode
        # (bottles.override {removeWarningPopup = true;})
        # games
        # beyond-all-reason
      ];
    };
}
