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
      };
    };
  };
}
