{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.settings.hypr;
in {
  options.settings = {
    hypr = {
      enable = lib.mkEnableOption "the Hypr module";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];

    programs.hyprland = {
      enable = true;
    };

    services.xserver = {
      enable = true;
      desktopManager.xterm.enable = false;
      displayManager.lightdm.enable = false;
    };

    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };

    security.rtkit = {
      enable = true;
    };

    xdg.autostart = {
      enable = true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
    };
  };
}
