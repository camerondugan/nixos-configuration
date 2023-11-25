sudo nixos-rebuild boot -I nixos-config=/home/$USER/.nixos/configuration.nix && git add . && git commit -m 'upload after build' && git push
