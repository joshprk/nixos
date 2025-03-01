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
        signcolumn = "number";

        laststatus = 3;
      };

      globals = {
        mapleader = " ";
        maplocalleader = ",";
      };

      highlight = {
        DiagnosticUnderlineError.undercurl = true;
        DiagnosticUnderlineHint.undercurl = true;
        DiagnosticUnderlineInfo.undercurl = true;
        DiagnosticUnderlineOk.undercurl = true;
        DiagnosticUnderlineWarn.undercurl = true;
      };

      keymaps = [
        {
          action = "\"+y";
          key = "y";
          options.noremap = true;
          mode = [
            "n"
            "v"
          ];
        }
        {
          action = "\"+p";
          key = "p";
          options.noremap = true;
          mode = [
            "n"
            "v"
          ];
        }
      ];

      colorschemes = {
        catppuccin = {
          enable = true;
          settings = {
            no_italic = true;
            transparent_background = true;
            custom_highlights = config.programs.nixvim.highlight;
          };
        };
      };

      plugins.blink-cmp = {
        enable = true;
        settings = {
          keymap.preset = "super-tab";
        };
      };

      plugins.fzf-lua = {
        enable = true;
      };

      plugins.lsp = {
        enable = true;
        servers = {
          nil_ls = {
            enable = true;
          };

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

      plugins.mini = {
        enable = true;
        mockDevIcons = true;
        modules = {
          icons = {};
        };

        luaConfig.post = ''
          local signs = {
            DiagnosticSignError = { text = "󰅙", },
            DiagnosticSignWarn = { text = "", },
            DiagnosticSignHint = { text = "", },
            DiagnosticSignInfo = { text = "", },
          }

          for i, v in pairs(signs) do
            vim.fn.sign_define(i, v)
          end
        '';
      };

      plugins.noice = {
        enable = true;
        settings = {
          presets.command_palette = true;
        };
      };

      plugins.persistence = {
        enable = true;
      };

      plugins.treesitter = {
        enable = true;
      };

      plugins.which-key = {
        enable = true;
        settings.preset = "helix";
      };
    };
  };
}
