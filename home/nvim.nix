{...}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    performance.byteCompileLua = {
      enable = true;
      configs = true;
      initLua = true;
      nvimRuntime = true;
    };

    opts = {
      expandtab = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      swapfile = false;
      signcolumn = "yes:1";
      relativenumber = true;
      confirm = true;
      cursorline = true;
      wrap = false;
    };

    globals = {
      mapleader = " ";
    };

    keymaps = [
      {
        action = "<Cmd>lua require(\"flash\").jump()<CR>";
        key = "s";
        options.desc = "Flash";
        mode = [
          "n"
          "x"
          "o"
        ];
      }
      {
        action = "<Cmd>lua require(\"flash\").treesitter()<CR>";
        key = "S";
        options.desc = "Flash Treesitter";
        mode = [
          "n"
          "x"
          "o"
        ];
      }
      {
        action = "<Cmd>FzfLua<CR>";
        key = "<leader><leader>";
        options.desc = "FzfLua";
        mode = [
          "n"
          "x"
          "o"
        ];
      }
    ];

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        transparent_background = true;
        show_end_of_buffer = false;
        no_italic = true;
      };
    };

    plugins.blink-cmp = {
      enable = true;
      settings = {
        keymap.preset = "super-tab";
      };
    };

    plugins.flash = {
      enable = true;
      settings = {
        modes.search.enabled = true;
      };
    };

    plugins.fzf-lua = {
      enable = true;
    };

    plugins.lsp = {
      enable = true;
      servers = {
        ccls.enable = true;
        pyright.enable = true;
        nixd.enable = true;
      };
    };

    plugins.lualine = {
      enable = true;
    };

    plugins.mini = {
      enable = true;
      mockDevIcons = true;
      modules = {
        pairs = {};
        icons = {};
      };
    };

    plugins.noice = {
      enable = true;
      settings = {
        presets.command_palette = true;
      };
    };

    plugins.snacks = {
      enable = true;
      settings = {
        indent = {
          enabled = true;
        };
        input = {
          enabled = true;
        };
        notifier = {
          enabled = true;
        };
        statuscolumn = {
          enabled = true;
        };
      };
    };

    plugins.treesitter = {
      enable = true;
      settings = {
        auto_install = true;
      };
    };

    plugins.which-key = {
      enable = true;
      settings = {
        preset = "helix";
      };
    };
  };
}
