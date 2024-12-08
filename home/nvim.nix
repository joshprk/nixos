{...}: {
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
    };

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
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustfmt = false;
          installRustc = false;
        };
      };
    };

    plugins.luasnip.enable = true;

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

    plugins.web-devicons.enable = true;

    plugins.telescope = {
      enable = true;
      extensions = {
        file-browser.enable = true;
      };
    };
  };
}
