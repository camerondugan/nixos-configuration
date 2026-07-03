{
  flake.homeModules.git = {pkgs, ...}: {
    # Ensure we use the right key
    programs.ssh = {
      matchBlocks = {
        "*" = {
          identityFile = ["~/.ssh/id_ed25519"];
        };
      };
    };

    home.packages = with pkgs; [
      jjui
    ];
    programs.jujutsu = {
      enable = true;
      settings = {
        user.name = "Cameron Dugan";
        user.email = "me@camerondugan.com";
        ui.default-command = "log";
      };
    };

    programs.git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user.name = "Cameron Dugan";
        user.email = "me@camerondugan.com";
      };
      signing.format = null;
      ## Desktop only setup rn
      # signing.key = "5A39B85F7BEE2BB880AF0F72A6E4FD72C9C868ED";
      # extraConfig.commit.gpgsign = true;
      # editor = "hx";
      # settings = {
      # user.name = "Cameron Dugan";
      # user.email = "cameron.dugan@protonmail.com";
      # core.editor = "hx";
      # pull.rebase = true;
      # };
    };

    programs.difftastic = {
      enable = true;
      git.enable = true;
      git.diffToolMode = true;
    };
  };
}
