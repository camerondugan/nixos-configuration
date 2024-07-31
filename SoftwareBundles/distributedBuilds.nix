{
  nix.distributedBuilds = true;
  nix.extraOptions = ''
    builders-use-substitutes = true
  '';
  nix.buildMachines = [
  {
      hostName = "desktop";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      speedFactor = 10;
      maxJobs = 3;
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" ];
      mandatoryFeatures = [];
  }
  {
      hostName = "laptop";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      maxJobs = 3;
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
