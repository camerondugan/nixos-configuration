{
  pkgs,
  lib,
  config,
  types,
  ...
}: {
  options.coding = {
    enable = lib.mkEnableOption "enables coding software";
    terminalPrompt.enable = lib.mkEnableOption "enhanced terminal prompt";
    editor = lib.mkOption {
      type = types.enum ["helix" "neovim"];
      default = "helix";
      description = "which editor do you use?";
    };
  };

  config = lib.mkIf config.coding.enable {
    # Program Config
    programs = {
      starship.enable = config.coding.terminalPrompt.enable;
      fish = {
        enable = true;
        interactiveShellInit =
          # bash
          ''
            set fish_greeting
            fish_vi_key_bindings
            bind --mode insert \cW 'fish_clipboard_copy' # disable ctrl+w
            bind --mode insert \b 'backward-kill-bigword' # rebind to ctrl+backspace
            fish_add_path /home/cam/.cargo/bin
            enable_transience
            set NIXPKGS_ALLOW_UNFREE 1
            # set ZELLIJ_AUTO_EXIT "true"
            if not set -q ZELLIJ
              if test "$ZELLIJ_AUTO_ATTACH" = "true"
                zellij attach -c
              else
                zellij
              end

              if test "$ZELLIJ_AUTO_EXIT" = "true"
                kill $fish_pid
              end
            end
          '';
        shellAliases = {
          # doesn't show these changes to user
          # force safer rm
          rm = "rmtrash";
          rmdir = "rmdirtrash";
          sl = "sl -ew";
        };
        shellAbbrs = {
          # Shows to the user the longer command
          # Force use of better commands
          m = "make";
          jm = "just -f makefile";
          jM = "just -f Makefile";
          lg = "lazygit";
          # cd = "z";
          np = "nix-shell --run fish -p";
          grep = "rg";
          gi = "gi >> .gitignore"; # append to gitignore
          ns = "nix-shell";
          du = "dust";
          # Kitty specific
          s = "kitten ssh";
          "-" = "cd -";
        };
      };
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

    environment.systemPackages = with pkgs; [
      # Shell
      fishPlugins.colored-man-pages
      fishPlugins.done
      fishPlugins.forgit
      fishPlugins.fzf
      fishPlugins.grc
      fishPlugins.pisces
      fishPlugins.puffer
      fishPlugins.z

      # Terminal Emulator
      helix
      codebook

      # Terminal Commands
      zip # create .zip
      unzip # unzip .zip
      rar # create .rar
      unrar # unzip .rar
      rmtrash # trash when rm (needs alias)
      zoxide # better cd (needs setup)
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
      tmate
      ffmpeg
      cargo
      cmake
      gnumake
      php
      nodePackages.npm
      wget
      ruby
      grc
      sshfs

      # # Android
      # android-tools
      # android-studio

      # Keyboard programming
      qmk

      # Neovim Extras
      bottom
      gdu
      luajit
      luajitPackages.luarocks-nix
      nodejs-slim
      php82Packages.composer
      tree-sitter
      imv
      # Lsp support
      stylua
      nixd # Nix
      nil
      alejandra
      typos-lsp
      gdtoolkit_4
      awk-language-server
      bash-language-server
      texlab
      bibtex-tidy
      netcoredbg
      clang-tools
      dfmt
      docker-compose-language-service
      dot-language-server
      typescript-language-server
      prettierd
      gopls
      delve
      haskell-language-server
      terraform-ls
      jq-lsp
      texlab
      vscode-langservers-extracted
      marksman
      nls
      ruff
      lldb
      slint-lsp
      snakefmt
      sourcekit-lsp
      templ
      txtpbfmt
      terraform-ls
      yaml-language-server
      zls
      lldb

      # Languages (no particular order)
      dotnet-sdk
      flutter
      gcc
      go
      rustup
      zig
      jdk
      clang
      # Python
      (python3.withPackages (ps:
        with ps; [
          pip
          pynvim
        ]))
    ];
  };
}
