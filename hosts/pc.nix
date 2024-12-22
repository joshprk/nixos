{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  # Prevents wireless mouse from preventing suspend
  services.udev.extraRules = ''
    ACTION=="add", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c094", ATTR{power/wakeup}="disabled"
    ACTION=="add", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c547", ATTR{power/wakeup}="disabled"
  '';

  networking.interfaces."eno1".wakeOnLan = {
    enable = true;
    policy = ["magic"];
  };

  powerManagement = {
    enable = true;
  };

  zramSwap.enable = true;
}
