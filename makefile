all:
	sudo nixos-rebuild switch --flake .#desktop # you should replace desktop with your config from flake.nix

update:
	nix flake update
