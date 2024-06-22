{ pkgs, ... }:

{
    # Program Configs
    programs.starship.enable = true;
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
        '';
        shellAbbrs = {
            # Force use of better commands
            cd="z";
            np = "nix-shell -p";
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

    ];
}
