{
  config,
  lib,
  options,
  homeManagerModules,
  ...
}: let
  cfg = config.settings.home;
in {
  options.settings = {
    home = {
      enable = lib.mkEnableOption "the home module";

      directory = lib.mkOption {
        type = lib.types.path;
        default = ../users;
        description = ''
          Which directory to look for user-specific home manager modules.
        '';
      };

      users = lib.mkOption {
        type = options.users.users.type;
        default = {};
        description = ''
          Alias of `users.users`.
        '';
      };
    };
  };

  config = let

  in lib.mkIf cfg.enable {
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      sharedModules = homeManagerModules;

      extraSpecialArgs = {};

      users = let
        getDir = dir: builtins.toPath "${cfg.directory}/${dir}";
        mkEntry = user: {
          name = user;
          value = import (getDir user);
        };
        names = builtins.attrNames cfg.users;
        filtered =
          builtins.filter (name: builtins.pathExists (getDir name)) names;
        entries = map mkEntry filtered;
      in
        builtins.listToAttrs entries;
    };

    users = {
      inherit (cfg) users;
      mutableUsers = false;
    };

    nix.settings = {
      use-xdg-base-directories = true;
    };

    /*
    xdg.terminal-exec = {
      enable = true;
      settings = {
        default = ["com.mitchellh.ghostty"];
      };
    };
    */
  };
}
