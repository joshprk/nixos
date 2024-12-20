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
      laststatus = 3;
      swapfile = false;
      wrap = false;

      splitbelow = true;
      splitright = true;
    };

    keymaps = [
      {
        action = "\"+ygv";
        key = "<C-c>";
        mode = ["v"];
      }
      {
        action = "<C-r>+";
        key = "<C-v>";
        mode = ["i"];
      }
      {
        action = "\"+p";
        key = "<C-v>";
        mode = ["n" "v"];
      }
    ];

    autoCmd = [
      {
        command = ''
          setlocal nonumber norelativenumber | setlocal signcolumn=no | tnoremap <Esc> <C-\><C-n> | startinsert
        '';
        event = ["TermOpen" "TermEnter"];
        pattern = ["term://*"];
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
    plugins.gitsigns.enable = true;
    plugins.noice.enable = true;
    plugins.which-key.enable = true;

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

    plugins.blink-cmp = {
      enable = true;
    };

    plugins.fzf-lua = {
      enable = true;
    };
  };
}
