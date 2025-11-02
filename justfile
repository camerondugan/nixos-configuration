all: add home

alias s := switch
alias b := boot
alias u := update
alias a := add

switch SYSTEM: add home
	sudo nixos-rebuild switch --flake .#{{SYSTEM}}

boot SYSTEM: add home
	sudo nixos-rebuild boot --flake .#{{SYSTEM}}

framework: add home
	sudo nixos-rebuild switch --flake .#framework13

razer: add home
	sudo nixos-rebuild switch --flake .#razer

desktop: add home
	sudo nixos-rebuild switch --flake .#desktop

update: add
	nix flake update

home: add
	home-manager switch --flake . -b backup

add:
	git add .
