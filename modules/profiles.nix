{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.settings.profiles;
in {
  options.settings = {
    profiles = {
      desktop = lib.mkEnableOption "the desktop profile";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.desktop {
      settings.home = {
        enable = true;
        users = {
          joshua = {
            isNormalUser = true;
            hashedPasswordFile = config.sops.secrets."users/joshua".path;
            shell = pkgs.zsh;
            extraGroups =
              [
                "wheel"
              ]
              ++ (lib.optional
                config.settings.networking.enable
                "networkmanager");
          };
        };
      };

      settings.hypr = {
        enable = true;
      };

      settings.secrets = {
        enable = lib.mkForce true;
      };

      settings.kernel = {
        quiet = true;
      };

      # TODO: automatic shell
      programs.zsh = {
        enable = true;
      };

      powerManagement = {
        enable = true;
      };

      # TODO: Make sops fix more robust
      sops.secrets."users/joshua".neededForUsers = true;
    })
  ];
}
