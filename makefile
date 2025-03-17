switch:
	sudo nixos-rebuild switch --flake .#desktop # you should replace desktop with your config from flake.nix

all: update switch home

update:
	nix flake update

home:
	home-manager switch --flake . -b back
