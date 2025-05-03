all: add home

framework: add home
	sudo nixos-rebuild switch --flake .#framework13

desktop: add home
	sudo nixos-rebuild switch --flake .#desktop

update: add
	nix flake update

home: add
	home-manager switch --flake . -b back

add:
	git add .
