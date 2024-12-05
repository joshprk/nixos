{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    nixos = {
      device = "/dev/nvme0n1p2";
      preLVM = true;
    };
  };

  hardware.nvidia.prime = {
    offload.enable = true;
    amdgpuBusId = "PCI:0:53:0";
    nvidiaBusId = "PCI:0:1:0";
  };

  services.tlp.enable = true;
}
