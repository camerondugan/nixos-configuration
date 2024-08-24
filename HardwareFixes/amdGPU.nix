{pkgs, ...}:
{
  boot.initrd.kernelModules = [ "amdgpu" ];
  # Use AMDVLK when applications prefer
  hardware.graphics.extraPackages = with pkgs; [
    amdvlk
  ];
  # For 32 bit applications 
  hardware.graphics.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];
}
