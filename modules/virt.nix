{
  config,
  lib,
  ...
}: let
  cfg = config.settings.virt;
in {
  options.settings = {
    virt = {
      enable = lib.mkEnableOption "the virt module";
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;
      dockerSocket.enable = true;
    };
  };
}
