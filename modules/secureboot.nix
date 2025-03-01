{
  config,
  lib,
  ...
}: let
  cfg = config.settings.secureboot;
in {
  options.settings = {
    secureboot = {
      enable = lib.mkEnableOption "the secureboot module";
    };
  };

  config = lib.mkIf cfg.enable {
    boot = {
      initrd.systemd.enable = lib.mkForce true;
      bootspec.enable = lib.mkForce true;
      loader.systemd-boot.enable = lib.mkForce false;

      lanzaboote = {
        enable = true;
        pkiBundle = "/etc/secureboot";
      };
    };

    settings.impermanence.extraDirectories = [
      config.boot.lanzaboote.pkiBundle
    ];
  };
}
