all: add switch home

switch: add
	sudo nixos-rebuild switch --flake .#desktop # you should replace desktop with your config from flake.nix

update: add
	nix flake update

home: add
	home-manager switch --flake . -b back

add:
	git add .
