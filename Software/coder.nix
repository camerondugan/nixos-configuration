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
        arch = "coreutils arch";
        base32 = "coreutils base32";
        base64 = "coreutils base64";
        basename = "coreutils basename";
        basenc = "coreutils basenc";
        cat = "coreutils cat";
        chgrp = "coreutils chgrp";
        chmod = "coreutils chmod";
        chown = "coreutils chown";
        chroot = "coreutils chroot";
        cksum = "coreutils cksum";
        comm = "coreutils comm";
        cp = "coreutils cp";
        csplit = "coreutils csplit";
        cut = "coreutils cut";
        date = "coreutils date";
        dd = "coreutils dd";
        df = "coreutils df";
        dir = "coreutils dir";
        dircolors = "coreutils dircolors";
        dirname = "coreutils dirname";
        du = "coreutils du";
        echo = "coreutils echo";
        env = "coreutils env";
        expand = "coreutils expand";
        expr = "coreutils expr";
        factor = "coreutils factor";
        false = "coreutils false";
        fmt = "coreutils fmt";
        fold = "coreutils fold";
        groups = "coreutils groups";
        hashsum = "coreutils hashsum";
        md5sum = "coreutils md5sum";
        sha1sum = "coreutils sha1sum";
        sha224sum = "coreutils sha224sum";
        sha256sum = "coreutils sha256sum";
        sha384sum = "coreutils sha384sum";
        sha512sum = "coreutils sha512sum";
        sha3sum = "coreutils sha3sum";
        shake128sum = "coreutils shake128sum";
        shake256sum = "coreutils shake256sum";
        b2sum = "coreutils b2sum";
        b3sum = "coreutils b3sum";
        head = "coreutils head";
        hostid = "coreutils hostid";
        hostname = "coreutils hostname";
        id = "coreutils id";
        install = "coreutils install";
        join = "coreutils join";
        kill = "coreutils kill";
        link = "coreutils link";
        ln = "coreutils ln";
        logname = "coreutils logname";
        ls = "coreutils ls";
        mkdir = "coreutils mkdir";
        mkfifo = "coreutils mkfifo";
        mknod = "coreutils mknod";
        mktemp = "coreutils mktemp";
        more = "coreutils more";
        mv = "coreutils mv";
        nice = "coreutils nice";
        nl = "coreutils nl";
        nohup = "coreutils nohup";
        nproc = "coreutils nproc";
        numfmt = "coreutils numfmt";
        od = "coreutils od";
        paste = "coreutils paste";
        pathchk = "coreutils pathchk";
        pinky = "coreutils pinky";
        pr = "coreutils pr";
        printenv = "coreutils printenv";
        printf = "coreutils printf";
        ptx = "coreutils ptx";
        pwd = "coreutils pwd";
        readlink = "coreutils readlink";
        realpath = "coreutils realpath";
        seq = "coreutils seq";
        shred = "coreutils shred";
        shuf = "coreutils shuf";
        sleep = "coreutils sleep";
        sort = "coreutils sort";
        split = "coreutils split";
        stat = "coreutils stat";
        stdbuf = "coreutils stdbuf";
        sum = "coreutils sum";
        sync = "coreutils sync";
        tac = "coreutils tac";
        tail = "coreutils tail";
        tee = "coreutils tee";
        timeout = "coreutils timeout";
        touch = "coreutils touch";
        tr = "coreutils tr";
        true = "coreutils true";
        truncate = "coreutils truncate";
        tsort = "coreutils tsort";
        tty = "coreutils tty";
        uname = "coreutils uname";
        unexpand = "coreutils unexpand";
        uniq = "coreutils uniq";
        unlink = "coreutils unlink";
        uptime = "coreutils uptime";
        users = "coreutils users";
        vdir = "coreutils vdir";
        wc = "coreutils wc";
        who = "coreutils who";
        whoami = "coreutils whoami";
        yes = "coreutils yes";
      };
      shellAbbrs = {
        # Shows to the user the longer command
        # Force use of better commands
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
