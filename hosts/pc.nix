{ config, lib, pkgs, ... }: {
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    consoleLogLevel = 3;
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "quiet"
      "splash"
    ];
  };

  zramSwap.enable = true;
}

