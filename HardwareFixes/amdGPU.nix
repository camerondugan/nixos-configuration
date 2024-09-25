{pkgs, ...}:
{
  nixpkgs.config.rocmSupport = true;
  boot.initrd.kernelModules = [ "amdgpu" ];
  # Use AMDVLK when applications prefer

  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
  ];
  # For 32 bit applications 
  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
  environment.systemPackages = with pkgs; [
    clinfo
  ];
}
