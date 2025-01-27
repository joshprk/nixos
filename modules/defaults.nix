{
  lib,
  extraModules,
  hostName,
  stateVersion,
  overlays,
  ...
}: {
  imports = extraModules;

  networking.networkmanager.enable = lib.mkDefault true;
  networking.hostName = hostName;
  time.timeZone = "America/New_York";
  system.stateVersion = stateVersion;

  nix.settings = {
    extra-experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "@wheel"
    ];
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = overlays;
  };
}
