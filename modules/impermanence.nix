{
  config,
  ...
}: {
  environment.persistence."/nix/persist" = let
    secureboot = if builtins.hasAttr "lanzaboote" config.boot then
      ["/etc/secureboot"]
    else [];

    openssh = if config.services.openssh.enable then
      ["/etc/ssh"]
    else [];

    tailscale = if config.services.tailscale.enable then
      ["/var/lib/tailscale"]
    else [];
  in {
    enable = true;
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/bluetooth"
    ]
    ++ secureboot
    ++ tailscale
    ++ openssh;

    files = [
      "/etc/machine-id"
    ];
  };
}
