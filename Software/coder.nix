{pkgs, ...}: {
  # Program Config
  programs = {
    starship.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        fish_vi_key_bindings
        bind --mode insert \cW 'fish_clipboard_copy' # disable ctrl+w
        bind --mode insert \b 'backward-kill-bigword' # rebind to ctrl+backspace
        fish_add_path /home/cam/.cargo/bin
        zoxide init fish | source
        direnv hook fish | source
        enable_transience
        set EDITOR $(which hx)
        if status is-interactive
            # Configure auto-attach/exit to your likings (default is off).
            # set ZELLIJ_AUTO_ATTACH true
            # set ZELLIJ_AUTO_EXIT true
            eval (zellij setup --generate-auto-start fish | string collect)
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
        lg = "lazygit";
        cd = "z";
        np = "nix-shell --run fish -p";
        grep = "rg";
        gi = "gi >> .gitignore"; # append to gitignore
        # Kitty specific
        s = "kitten ssh";
      };
    };
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
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
    fishPlugins.sponge
    fishPlugins.z

    # Terminal Emulator
    ghostty
    helix

    # Terminal Commands
    zip # create .zip
    unzip # unzip .zip
    rar # create .rar
    unrar # unzip .rar
    rmtrash # trash when rm (needs alias)
    zoxide # better cd (needs setup)
    lsd # better ls
    lf # file explorer
    sl # Steam Locomotive
    mpv # View Media
    bat # better cat
    fzf # fuzzy finder
    ripgrep # RIP grep
    devenv # developer env
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
    lua-language-server
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
    bitbake-language-server
    blueprint-compiler
    netcoredbg
    haskell-language-server
    clojure-lsp
    cmake-language-server
    codeql
    clang-tools
    crystalline
    cuelsp
    cue
    dfmt
    serve-d
    dhall-lsp-server
    docker-compose-language-service
    dot-language-server
    earthlyls
    elixir-ls
    elvish
    erlang-ls
    fortls
    fsautocomplete
    typescript-language-server
    gleam
    ember-language-server
    prettierd
    gopls
    delve
    haskell-language-server
    terraform-ls
    hyprls
    inko
    jdt-language-server
    jq-lsp
    julia
    koka
    kotlin-language-server
    koto-ls
    texlab
    lean
    marksman
    mesonlsp
    mint
    nls
    nimlangserver
    openscad-lsp
    perlnavigator
    pest-ide-tools
    intelephense
    ruff
    R
    racket
    regols
    rescript-language-server
    robotframework-tidy
    solargraph
    lldb
    metals
    vscode-langservers-extracted
    slint-lsp
    snakefmt
    svelte-language-server
    sourcekit-lsp
    swift-format
    templ
    txtpbfmt
    terraform-ls
    taplo
    ts_query_ls
    tinymist
    vala-language-server
    vhdl-ls
    vue-language-server
    sv-lang
    wgsl-analyzer
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
    godot
    # Python
    (python3.withPackages (ps:
      with ps; [
        pip
        pynvim
      ]))
  ];
}
