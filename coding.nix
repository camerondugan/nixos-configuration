{ pkgs, ... }:

{
    # Program Configs
    programs.starship.enable = true;
    programs.tmux = {
        enable = true;
        plugins = with pkgs; [
            tmuxPlugins.resurrect
            tmuxPlugins.continuum
        ];
    };
    programs.fish = {
        enable = true;
        interactiveShellInit = ''
          pfetch
          set fish_greeting
          fish_vi_key_bindings
          bind --mode insert \cW 'fish_clipboard_copy' # disable ctrl+w
          bind --mode insert \b 'backward-kill-bigword' # rebind to ctrl+backspace
          alias rm="rmtrash"
          alias rmdir="rmdirtrash"
          alias sl="sl -ew"
          fish_add_path /home/cam/.cargo/bin
          zoxide init fish | source
          direnv hook fish | source
          enable_transience
        '';
        shellAbbrs = {
            # Force use of better commands
            cd="z";
            np = "nix-shell --run fish -p";
            grep="rg";
            gi="gi >> .gitignore"; # append to gitignore
            tat="tmux a -t"; # Attach to session
            tnt="tmux new -t"; # Create new session
            td="tmux detach"; # Exit session while saving it
        };
    };

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

        # Terminal Commands
        zip # create .zip
        unzip # unzip .zip
        rar # create .rar
        unrar # unzip .rar
        rmtrash # trash when rm (needs alias)
        zoxide # better cd (needs setup)
        lf # file explorer
        sl # Steam Locomotive
        mpv # View Media
        tmate
        networkmanagerapplet
        pavucontrol
        youtube-tui
        yt-dlp
        ffmpeg
        unsilence
        cargo
        cmake
        gnumake
        php
        nodePackages.npm
        wget
        ruby
        fzf
        grc
        pfetch
        sshfs

        # Android
        android-tools
        android-studio

        # Software Dev Tools
        direnv
        devenv
        kitty
        lazygit
        ripgrep
        fd
        httplz
        gdb
        steam-run
        optipng
        jpegoptim
        ntfy-sh

        # Nvim required
        bottom
        gdu
        luajit
        luajitPackages.luarocks-nix
        nodejs-slim
        php82Packages.composer
        tree-sitter
        imv

        # Languages (no particular order)
        dotnet-sdk
        flutter
        gcc
        go
        rstudio
        rustup
        zig
        jdk
        clang
        julia-bin
        godot_4
        # Python
        (python3.withPackages(ps: with ps; [
            pip
            pynvim
        ]))
    ];
}
