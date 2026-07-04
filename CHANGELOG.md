# Changelog

All notable changes to this project will be documented in this file.

## [unreleased]

### 🚀 Features

- No more hyprctl reload, wpaper transition change, nvim lsp support
- Cosmic desktop as default all machines
- Ghostty font size increase, blocky dns
- Added back a notification center
- Bringing back widgets
- Sirula config c
- Even less keys required hyprland
- *(simplicity)* Remove fullscreen shortcut
- Hyprland waybar reloading on conf change
- Better mouse and window resize with aspect ratio kept
- More rustification
- *(dock)* Nwg-dock-hyprland
- *(ly)* New hyprland display manager
- Transparency, blur, active border color, and more wiggle room
- *(batsignal)* Warns on low battery without need for waybar
- More beautiful blur
- Browser and terminal now start on their respective workspaces encouraging their usage in this way
- *(day/night)* Colorschemes autoswitch as needed
- *(theming-and-structure)* No comment
- *(geoclue2,spellchecking)* In some languages
- *(home-manager)* Moving more configs over to being native to home-manager
- *(stylix)* Gruvbox
- *(batsignal)* Warns on low battery without need for waybar
- Dhh inspired web browser rice
- Hyprsunset
- Commit to one wallpaper, theme everything on just that one
- More tui integrations
- Cachix
- More shortcuts
- Better pulsemixer and fixed zoxide
- Setup exa as ls
- Flatwhite remove stylix from terminals
- Helix integrations and keybindings
- *(tty-browsing)* Lynx and ddgr
- *(whichkey)* And more attempts at splitting to parts
- *(cosmic)* Switch to cosmic with the system76-scheduler
- *(flake-parts)* Migration done for desktop, other machines are ooc until updated
- *(nvim)* Added simple nvim config
- *(direnv)* New module
- *(tailscale)* Added module
- *(nvim)* Lualine
- *(nvim)* DiffViewOpen
- *(framework13)* Added back in framework13 target
- *(jujutsu)* It's git, but without staging area

### 🐛 Bug Fixes

- Reinstall nil and typos_lsp and fix warning
- '...' and not self, Godot not Godot_4
- Better make, updated flake, commented out broken package
- Capitalization
- Hyprland modifiers are now based on my personal use
- *(scrollbar)* Reduce touchpad scrolling amount
- Hide ethernet ipaddr?
- Helix can use system clipboard now
- Zellij is now optional on term start
- Removed core utils at the first sign of danger
- *(waybar)* Better audio and bluetooth management gui workflow
- *(hyprland)* Better tiling behavior (prefer slightly taller)
- *(colors)* I still prefer solarized
- Removed things I don't need/use
- *(zellij)* Made zellij my default terminal session
- Dwindle shortcut works
- Partial fix for suspend/login problems
- Desktop suspend resume works now
- Darkman not having access to the required pkgs
- Make inactive windows identifiable
- *(minor)* Zellij
- Kde connect removed dup
- Toggle more menu items
- Idk
- Blinding wallpaper removed
- Only one way to do things
- Discord is now chrome web app
- Improvements in speed and usability
- Ghostty better close
- Hyprsunset was useless, so using sunsetr to control hyprsunset
- Wezterm now matches ghostty font size
- Darkman couldn't find nix-build (fix by subtraction)
- Hyprland
- Helix faster goto_word
- Helix rulers at 80 and 120
- Helix ZZ emulation without write bc they forgot to make the command
- Update deps, improve helix experience, hyprland tweaks
- Switch wallpaper
- Update deps, improve helix experience, hyprland tweaks
- Switch to stable :(
- Waybar min 3 workspaces
- Bottles unsupported env warning disable
- Add justfile, but also syncthing magically broke :(
- Switch to lix
- Zellij to locked default mode
- Nvidia vars
- Signed commit?
- Attempt signed commit 3
- Harper ls and changed from sleep to shutdown on idle
- Discovered quickshell exists
- Caelestia home-manager module
- Less software since new shell provides notification features
- Gaming beyond all reason install
- Some shell settings
- Microphone not needed to be shown in bar
- Remove dependency on swayosd
- Small changes
- Small improvements
- Smaller improvements
- *(hyprland)* File pickers, notifications improvements
- Small changes
- Update flakes and fix for caelestia shell sleep on system without hibernate
- *(pulsemixer)* Build my customized flake into this customized flake
- *(framework)* Gaming
- *(idek)* Yes this is how bad it is getting in this repo
- *(ollama/cuda)* Desktop
- *(update)* Flake latest
- *(os-version)* Bump to unstable :)
- *(required changes for prev commit)* Yay
- *(hyprland)* Attempt to fix issues
- *(idek)* Help
- *(shrink)* Update flake and remove a bunch of stuff I devenv + flake anyways
- *(framework)* Setup to work from mainline min changes
- *(hyprland)* Make widescreen manageable on one window open
- *(grc)* You no longer need to install grc
- *(framework)* Trackpad sensitivity dialed in a bit better
- *(many modules)* Formatting + modularity improvements
- *(idek)* Pretty sure this commit is broke
- *(rmtrash|hyprland)* Don't worry bout it
- *(hypr)* Migrate hyprland over to nix native configuration
- *(hyprland)* Numlock default
- *(update)* Bump flake.lock
- *(z)* Zoxide installation competed with the z fish shell implementation
- *(many)* Cachyos, whichkey, cosmic switch
- *(updates)* And signal
- *(ghostty)* Selenized
- *(helix)* Work around awful theming problems
- *(font-size)* Hi mom
- *(gaming)* Not even really sure what to say for this one
- *(editor)* And update flake
- *(ollama)* Cuda and normal modules
- *(nvim)* Added back a lot of helix functionality to nvim
- *(nvim)* Treesitter use all grammars
- *(nvim)* Refaktor
- *(browser)* Add chromium default
- *(update)* Cachyos broke update I think...
- *(nvim)* Lazygit
- *(nvim)* Set EDITOR variable in fish (nix handled it poorly)
- *(update)* And mostly formatting
- *(colorschemes)* Ghostty and neovim are both now zenbones
- *(tmp)* Builds
- *(keyd)* Setup key daemon for normal keyboards being good again
- *(nvim)* Lua_ls
- *(xdg-portals)* No idea if this is good, will test later
- *(productivity)* Add organisation system
- *(git-cliff)* Setup for this repo and add a flake-parts module

### 💼 Other

- Flake
- Update, difft, tinkering with wezterm
- Flake lock
- *(flake-parts)* It is working
- *(flake-parts)* Keyd and betterCaps modules

### 🚜 Refactor

- *(nixpkgs)* Switched to stable
- *(modules)* Switching over to modules for more coherence
- *(modules)* Moving files around
- *(modules)* Setup desktop
- *(modules)* Moved coder into where it belongs: nix-modules
- *(config)* Moving files around and small tweaks
- *(hyperland)* Add arrows, pending layout rework, something isn't right
- *(flake-parts/import-tree)* Moved gaming module
- *(flake-parts)* Distributed-builds?

### ⚙️ Miscellaneous Tasks

- Update flake
- Less config :)
- Update
- *(theme)* Set to ayu bc i like
- *(formatting)* Just format
- *(misc)* Not even sure what happened here

<!-- generated by git-cliff -->
