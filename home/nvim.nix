{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    opts = {
      number = true;
      signcolumn = "yes:1";
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      autoindent = true;
      smartindent = true;
      swapfile = false;
      wrap = false;

      clipboard = "unnamedplus";

      splitbelow = true;
      splitright = true;
    };

    keymaps = [
      {
        action = "<Cmd>Telescope file_browser<CR>";
        key = "<Tab>";
        options = {
          silent = true;
        };
      }
      {
        action = "y";
        key = "<C-c>";
        mode = ["v"];
      }
      {
        action = "<Esc>pa";
        key = "<C-v>";
        mode = ["i"];
      }
      {
        action = "p";
        key = "<C-v>";
        mode = ["n"];
      }
      {
        action = "x<C-v>";
        key = "<C-v>";
        mode = ["v"];
      }
    ];

    autoCmd = [
      {
        command = ''
          setlocal nonumber norelativenumber | setlocal signcolumn=no | tnoremap <Esc> <C-\><C-n>
        '';
        event = ["TermOpen"];
        pattern = ["*"];
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

    performance.byteCompileLua.enable = true;

    plugins.lualine.enable = true;
    plugins.luasnip.enable = true;
    plugins.web-devicons.enable = true;

    plugins.lsp = {
      enable = true;
      servers = {
        ccls.enable = true;
        pyright.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustfmt = false;
          installRustc = false;
        };
      };
    };

    plugins.cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        sources = [
          {name = "luasnip";}
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
        ];

        window.completion.border = "rounded";
      };
    };

    plugins.telescope = {
      enable = true;
      extensions = {
        file-browser.enable = true;
      };
    };
  };
}
