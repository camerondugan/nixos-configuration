{ config, pkgs, ... }:

{
  imports = [
    ../SoftwareBundles/gamer.nix
    ../SoftwareBundles/coder.nix
    #./cosmic.nix
  ];

  networking.hostName = "Desktop"; # Define your hostname.
  boot.initrd.luks.devices."luks-d61365ad-2360-44ee-af96-eabea1511510".device = "/dev/disk/by-uuid/d61365ad-2360-44ee-af96-eabea1511510";

  # mount drive
  fileSystems."/mnt/FireCuda" = {
    device = "/dev/nvme1n1p1";
    fsType = "auto";
  };

  environment.systemPackages = with pkgs; [
    clonehero
  ];

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  # make gamescope fullscreen by default
  programs.gamescope.args = ["-f"];

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
  #nixpkgs.config.rocmSupport = true;
  #nixpkgs.config.rocmTargets = ["gfx1031"];
  hardware.graphics.extraPackages = [ pkgs.rocm-opencl-icd ];
  hardware.amdgpu.opencl.enable = true;
  services.ollama.package = pkgs.ollama-rocm;
  services.ollama.acceleration = "rocm";
  services.ollama.environmentVariables = {
    HCC_AMDGPU_TARGET = "gfx1031";
  };
  services.ollama.rocmOverrideGfx = "10.3.1";
}
