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
          set fish_greeting
          fish_vi_key_bindings
          bind --mode insert \cW 'fish_clipboard_copy' # disable ctrl+w
          bind --mode insert \b 'backward-kill-bigword' # rebind to ctrl+backspace
          fish_add_path /home/cam/.cargo/bin
          zoxide init fish | source
          direnv hook fish | source
          enable_transience
        '';
        shellAliases = { # doesn't show these changes to user
            # force safer rm
            rm="rmtrash";
            rmdir="rmdirtrash";
            sl="sl -ew";
        };
        shellAbbrs = { # Shows to the user the longer command
            # Force use of better commands
            lg="lazygit";
            cd="z";
            np = "nix-shell --run fish -p";
            grep="rg";
            gi="gi >> .gitignore"; # append to gitignore
            # Kitty specific
            s="kitten ssh";
            # TMUX
            tat="tmux a -t"; # Attach to session
            tnt="tmux new -t"; # Create new session
            td="tmux detach"; # Exit session while saving it
        };
    };
    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
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

        # Nvim required
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
        nixd
        nil
        typos-lsp

        # Languages (no particular order)
        dotnet-sdk
        flutter
        gcc
        go
        rustup
        zig
        jdk
        clang
        godot_4
        # Python
        (python3.withPackages(ps: with ps; [
            pip
            pynvim
        ]))
    ];
}
