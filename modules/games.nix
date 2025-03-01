{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.settings.games;
in {
  options.settings = {
    games = {
      enable = lib.mkEnableOption "the games module";

      packages = lib.mkOption {
        type = lib.types.listOf (lib.types.attrs {
          name = lib.types.str;
          package = lib.types.package;
        });
        default = [];
        description = ''
          Extra packages to install in the games sandbox.
        '';
      };
    };
  };

  config = let
    mkSandbox = lib.makeOverridable ({
      name,
      package,
      ...
    }: {
      inherit (package) passthru;
      inherit name;

      targetPkgs = _: [package];

      runScript = name;
      mainProgram = lib.getExe package;

      chdirToPwd = false;
      dieWithParent = true;

      extraBwrapArgs = [
        "--bind $XDG_DATA_HOME/games $HOME"
        "--chdir $HOME"
        "--dir $HOME"
        "--dir XDG_CACHE_HOME"
        "--dir XDG_CONFIG_HOME"
        "--dir XDG_DATA_HOME"
        "--dir XDG_STATE_HOME"
      ];
    });
  in
    lib.mkIf cfg.enable {
      environment.systemPackages = builtins.map mkSandbox cfg.packages;

      programs.steam = {
        enable = true;
        package = mkSandbox {
          name = "steam";
          package = pkgs.steam;
        };
      };
    };
}
