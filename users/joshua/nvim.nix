{
  config,
  lib,
  ...
}: let
  cfg = config.user.nvim;
in {
  options.user = {
    nvim = {
      enable = lib.mkEnableOption "the Neovim configuration";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;

      opts = {
        expandtab = true;
        tabstop = 2;
        softtabstop = 2;
        shiftwidth = 2;
      };
    };
  };
}
