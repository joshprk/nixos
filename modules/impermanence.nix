{config, lib, ...}: {
  environment.persistence."/nix/persist" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/etc/nixos"
      (lib.mkIf (config.boot.lanzaboote != null) "/etc/secureboot")
    ];
  };

  # fix agenix ssh
  fileSystems."/home".neededForBoot = true;
}
