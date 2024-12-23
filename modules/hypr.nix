{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "Hyprland";
        user = "joshua";
      };
      default_session = initial_session;
    };
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.xserver = {
    enable = true;
    excludePackages = [pkgs.xterm];
  };

  programs.hyprland.enable = true;

  security.rtkit.enable = true;
}
