all: add switch home

switch: add
	sudo nixos-rebuild switch --flake .#framework13 # you should replace framework13 with your config from flake.nix

update: add
	nix flake update

home: add
	home-manager switch --flake . -b back

add:
	git add .
