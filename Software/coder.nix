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
        cd = "z";
        np = "nix-shell --run fish -p";
        grep = "rg";
        gi = "gi >> .gitignore"; # append to gitignore
        ns = "nix-shell";
        du = "dust";
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
    xh # Friendly and fast tool for sending http requests
    lsd # better ls
    dust # better du
    delta # better git diff
    yazi # file explorer
    hyperfine # benchmarking tool
    bacon # rust diagnostic tool
    tokei # project lang summary
    just # just better make
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
}
