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

      autoLogin = {
        enable = lib.mkEnableOption "autologin for Hyprland";

        defaultUser = lib.mkOption {
          type = lib.types.str;
          description = ''
            Which user to automatically start a Hyprland session with.
          '';
        };
      };
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

    services.greetd = lib.mkIf cfg.autoLogin.enable {
      enable = true;
      settings = {
        initial_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          username =
            if
              (
                builtins.hasAttr
                cfg.autoLogin.defaultUser
                config.users.users
              )
            then cfg.autoLogin.defaultUser
            else throw "settings.hypr.autoLogin.defaultUser is not a valid user";
        };
      };
    };

    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };

    services.xserver = {
      enable = true;
      desktopManager.xterm.enable = false;
      displayManager.lightdm.enable = false;
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
