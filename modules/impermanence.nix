{...}: {
  environment.persistence."/nix/persist" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/etc/secureboot"
      "/etc/nixos"
      "/var/log"
      "/var/lib/nixos"
    ];
    files = [
      "/etc/machine-id"
    ];
  };
}
