{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # fix stutter on terminal due to offload
  boot.kernelParams = ["amdgpu.dcdebugmask=0x10"];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices = {
    nixos = {
      device = "/dev/nvme0n1p2";
      preLVM = true;
    };
  };

  hardware.nvidia.powerManagement.finegrained = true;
  hardware.nvidia.prime = {
    offload.enable = true;
    amdgpuBusId = "PCI:0:53:0";
    nvidiaBusId = "PCI:0:1:0";
  };

  networking.networkmanager.wifi.powersave = true;

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services.tlp.enable = true;
}
