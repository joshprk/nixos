{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.nvidia.nvidiaPersistenced = true;
  systemd.services.nvidia-underclock = {
    description = "Limits NVIDIA GPU clocks to 1900MHz and overclocks memory by +1000MHz";
    wantedBy = ["multi-user.target"];
    script = ''
      /run/current-system/sw/bin/nvidia-smi --lock-gpu-clocks 0,1090
      /run/current-system/sw/bin/nvidia-smi --lock-memory-clocks=0,10501
    '';
  };

  networking.interfaces."eno1".wakeOnLan = {
    enable = true;
    policy = ["magic"];
  };

  zramSwap.enable = true;
}
