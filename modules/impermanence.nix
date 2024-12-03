{...}: {
  environment.persistence."/nix/persist" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/etc/nixos"
    ];
  };

  # fix agenix ssh
  fileSystems."/home".neededForBoot = true;
}
