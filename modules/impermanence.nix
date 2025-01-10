{config, lib, ...}: {
  environment.persistence."/nix/persist" = {
    enable = true;
    hideMounts = true;
    directories = [
      (lib.mkIf (config.boot.lanzaboote != null) "/etc/secureboot")
      "/etc/nixos"
      "/var/log"
      "/var/lib/nixos"
    ];
    files = [
      "/etc/machine-id"
    ];
  };
}
