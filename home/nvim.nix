{
  config,
  lib,
  pkgs,
  ...
}: {
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
    };
    
    plugins.lsp = {
      enable = true;
      servers = {
        pyright.enable = true;
      };
    };

    plugins.blink-cmp = {
      enable = true;
    };
  };
}
