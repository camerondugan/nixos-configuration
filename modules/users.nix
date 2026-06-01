{
  flake.nixosModules.users = {
    users.users.cam = {
      isNormalUser = true;
      description = "Cameron Dugan";
      extraGroups = [
        "networkmanager"
        "wheel"
        "input"
        "libvirtd"
        "kvm"
        "qemu-libvirtd"
      ];
    };
  };
}
