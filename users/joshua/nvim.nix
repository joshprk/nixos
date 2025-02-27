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

        cursorline = true;
        number = true;
        relativenumber = true;
        signcolumn = "yes:1";

        laststatus = 3;
      };

      colorschemes = {
        catppuccin = {
          enable = true;
          settings = {
            no_italic = true;
            transparent_background = true;
          };
        };
      };

      plugins.blink-cmp = {
        enable = true;
        settings = {
          keymap.preset = "super-tab";
        };
      };

      plugins.lsp = {
        enable = true;
        servers = {
          pyright = {
            enable = true;
          };

          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
            installRustfmt = false;
          };
        };
      };

      plugins.lualine = {
        enable = true;
      };

      plugins.noice = {
        enable = true;
        settings = {
          presets.command_palette = true;
        };
      };
    };
  };
}
