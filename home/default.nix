{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./programs.nix
    ./hypr.nix
    ./nvim.nix
  ];

  home.username = "joshua";
  home.homeDirectory = "/home/joshua";
  home.stateVersion = "24.05";

  home.sessionVariables = {
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";
    PYTHON_HISTORY = "${config.xdg.stateHome}/python/history";
    IPYTHONDIR = "${config.xdg.configHome}/ipython";
  };

  home.shellAliases = {
    steam = "flatpak run com.valvesoftware.Steam";
  };

  home.pointerCursor = {
    name = "catppuccin-mocha-dark-cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 22;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;

    font = {
      name = "JetBrainsMono NerdFont";
      size = 12;
      package = pkgs.nerd-fonts.jetbrains-mono;
    };

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  xdg = {
    enable = true;
    userDirs.createDirectories = false;
  };
}
