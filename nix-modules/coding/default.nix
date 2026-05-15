{
  pkgs,
  lib,
  config,
  types,
  ...
}:
{
  options.coding = {
    enable = lib.mkEnableOption "enables coding software";
    terminalPrompt.enable = lib.mkEnableOption "enhanced terminal prompt";
    editor = lib.mkOption {
      type = types.enum [
        "helix"
        "neovim"
      ];
      default = "helix";
      description = "which editor do you use?";
    };
  };

  config = lib.mkIf config.coding.enable {
    # Program Config
    programs = {
      starship.enable = config.coding.terminalPrompt.enable;
      neovim = {
        enable = lib.mkIf config.editor == "neovim";
        viAlias = lib.mkIf config.editor == "neovim";
        vimAlias = lib.mkIf config.editor == "neovim";
      };
    };

    # QMK permissions for my keyboard
    services.udev.extraRules = ''
      KERNEL=="ttyACM0", MODE:="666"
    '';
    services.udev.packages = [
      pkgs.openocd
    ];

    environment.systemPackages = with pkgs; [
      cachix

      # Terminal Commands
      grc
      zip # create .zip
      unzip # unzip .zip
      rar # create .rar
      unrar # unzip .rar
      xh # Friendly and fast tool for sending http requests
      lsd # better ls
      dust # better du
      difftastic # better diff
      yazi # file explorer
      hyperfine # benchmarking tool
      bacon # rust diagnostic tool
      tokei # project lang summary
      just # just better make
      watchexec # better entr
      sl # Steam Locomotive
      mpv # View Media
      bat # better cat
      fzf # fuzzy finder
      ripgrep # RIP grep
      devenv # developer env
      git
      lazygit
      eza
      cargo
      gnumake
      wget

      # # Android
      # android-tools
      # android-studio

      # Keyboard programming
      # qmk

      # Neovim Extras
      # bottom
      # gdu
      # luajit
      # luajitPackages.luarocks-nix
      # nodejs-slim
      # php82Packages.composer
      # tree-sitter
      # imv
      # Lsp support
      # stylua
      nixd # Nix
      nil
      alejandra
      # typos-lsp
      # gdtoolkit_4
      # awk-language-server
      bash-language-server
      # texlab
      # bibtex-tidy
      # netcoredbg
      # clang-tools
      # dfmt
      docker-compose-language-service
      # dot-language-server
      # typescript-language-server
      # prettierd
      # gopls
      # delve
      # haskell-language-server
      # terraform-ls
      # jq-lsp
      # texlab
      # vscode-langservers-extracted
      marksman
      markdown-oxide
      # nls
      # ruff
      # lldb
      # slint-lsp
      # snakefmt
      # sourcekit-lsp
      # templ
      # txtpbfmt
      # terraform-ls
      # yaml-language-server
      # zls
      # lldb

      # Languages (no particular order)
      # dotnet-sdk
      # flutter
      # gcc
      # go
      # rustup
      # zig
      # jdk
      # clang
      # Python
      (python3.withPackages (
        ps: with ps; [
          pip
          pynvim
        ]
      ))
      libresprite
    ];
  };
}
