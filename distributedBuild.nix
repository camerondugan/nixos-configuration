{config, lib, pkgs, ...}:

{
  nix.buildMachines = [
  {
      hostName = "desktop";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" ];
      mandatoryFeatures = [];
  }
  {
      hostName = "laptop";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" ];
      mandatoryFeatures = [];
  }
  {
      hostName = "thinkpad";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" ];
      mandatoryFeatures = [];
  }
  ];
}
