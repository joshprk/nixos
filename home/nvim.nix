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
      number = true;
      confirm = true;
    };

    globals = {
      mapleader = " ";
    };

    keymaps = [
      {
        action = "<Cmd>lua require(\"flash\").jump()<CR>";
        mode = ["n" "x" "o"];
        key = "s";
        options.desc = "Flash";
      }
      {
        action = "<Cmd>lua require(\"flash\").treesitter()<CR>";
        mode = ["n" "x" "o"];
        key = "S";
        options.desc = "Flash Treesitter";
      }
      {
        action = "<Cmd>FzfLua<CR>";
        mode = ["n" "x" "o"];
        key = "<leader><leader>";
        options.desc = "FzfLua";
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
    
    plugins.lsp = {
      enable = true;
      servers = {
        ccls.enable = true;
        pyright.enable = true;
        nixd.enable = true;
      };
    };

    plugins.treesitter = {
      enable = true;
      settings = {
        auto_install = true;
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

    plugins.which-key = {
      enable = true;
      settings = {
        preset = "helix";
      };
    };

    plugins.mini = {
      enable = true;
      mockDevIcons = true;
      modules = {
        pairs = {};
        icons = {};
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

    plugins.noice = {
      enable = true;
      settings = {
        presets.command_palette = true;
      };
    };

    plugins.lualine = {
      enable = true;
    };

    plugins.flash = {
      enable = true;
      settings = {
        modes.search.enabled = true;
      };
    };
  };
}
