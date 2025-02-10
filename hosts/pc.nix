{pkgs, ...}: {
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    consoleLogLevel = 3;
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "nvidia.NVreg_TemporaryFilePath=/var/tmp"
      "nvidia.NVreg_DynamicPowerManagement=0x02"
      "nvidia.NVreg_UsePageAttributeTable=1"
      "quiet"
      "splash"
    ];
  };

  hardware = {
    nvidia.nvidiaPersistenced = true;
  };

  systemd.services.nvidia-underclock = {
    description = "Limits NVIDIA GPU clocks to 1700MHz and overclocks memory by +500MHz";
    wantedBy = ["multi-user.target"];
    script = ''
      /run/current-system/sw/bin/nvidia-smi --lock-gpu-clocks 0,1700
      /run/current-system/sw/bin/nvidia-smi --lock-memory-clocks=0,10001
    '';
  };

  powerManagement = {
    enable = true;
  };

  zramSwap.enable = true;
}
