{
  config,
  lib,
  options,
  ...
}: let
  cfg = config.settings.secrets;
in {
  options.settings = {
    secrets = {
      enable = lib.mkEnableOption "the secrets module";

      directory = lib.mkOption {
        type = lib.types.path;
        default = ../secrets;
        description = ''
          The directory where the secrets files are stored.
        '';
      };

      format = lib.mkOption {
        type = options.sops.defaultSopsFormat.type;
        default = "yaml";
        description = ''
          Alias of `sops.defaultSopsFormat`.
        '';
      };

      keyFile = lib.mkOption {
        type = lib.types.str;
        default = "/nix/keys";
        description = ''
          The file where the private keys are stored.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    sops.defaultSopsFormat = cfg.format;
    sops.defaultSopsFile = cfg.directory + "/default." + cfg.format;
    sops.age.keyFile = cfg.keyFile;
  };
}
