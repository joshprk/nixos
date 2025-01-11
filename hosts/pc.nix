{pkgs, ...}: {
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    consoleLogLevel = 3;
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "NVreg_UsePageAttributeTable=1"
      "quiet"
      "splash"
    ];
  };

  zramSwap.enable = true;
}
