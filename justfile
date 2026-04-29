all: add home

alias s := switch
alias b := boot
alias u := update
alias h := home
alias a := add

switch SYSTEM: add
	sudo nixos-rebuild switch --flake .#{{SYSTEM}}
	@just home

boot SYSTEM: add
	sudo nixos-rebuild boot --flake .#{{SYSTEM}}
	@just home

framework: add
	sudo nixos-rebuild switch --flake .#framework13
	@just home

razer: add
	sudo nixos-rebuild switch --flake .#razer
	@just home

desktop: add
	sudo nixos-rebuild switch --flake .#desktop
	@just home

update: add
	nix flake update

home: add
	home-manager switch --flake . -b hm-backup

format:
	alejandra .

add:
	git add .
