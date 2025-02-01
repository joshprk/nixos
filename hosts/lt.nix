{pkgs, ...}: {
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    consoleLogLevel = 3;
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "amdgpu.dcdebugmask=0x10"
      "quiet"
      "splash"
    ];
  };

  hardware.nvidia = {
    powerManagement.finegrained = true;
    prime = {
      amdgpuBusId = "PCI:1:0:0";
      nvidiaBusId = "PCI:53:0:0";
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };

  powerManagement = {
    enable = true;
  };

  zramSwap.enable = true;
}
