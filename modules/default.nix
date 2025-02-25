{
  lib,
  hostName,
  stateVersion,
  overlays,
  ...
}: {
  config = {
    networking = {
      inherit hostName;
    };

    system = {
      inherit stateVersion;
    };

    time = {
      timeZone = lib.mkDefault "America/New_York";
    };

    nix.settings = {
      extra-experimental-features = lib.mkDefault [
        "nix-command"
        "flakes"
      ];
    };

    nixpkgs = {
      inherit overlays;
      config.allowUnfree = lib.mkDefault true;
    };
  };
}
