all: add home

alias s := switch
alias b := boot
alias u := update
alias h := home
alias a := add

switch SYSTEM: add
	sudo nixos-rebuild switch --flake .#{{SYSTEM}} --max-jobs 4 --cores 4
	@just home

boot SYSTEM: add
	sudo nixos-rebuild boot --flake .#{{SYSTEM}}
	@just home

framework: add
	just switch framework13

razer: add
	just switch razer

desktop: add
	just switch desktop

update: add
	nix flake update

home: add
	home-manager switch --flake . -b hm-backup

format:
	alejandra .

add:
	git add .
