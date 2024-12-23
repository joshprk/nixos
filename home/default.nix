{
  config,
  lib,
  pkgs,
  ...
} @ inputs: {
  imports = [
    ./hypr.nix
    ./nvim.nix
    ./programs.nix
    ./stylix.nix
    ./waybar.nix
  ];

  home.username = "joshua";
  home.homeDirectory = "/home/joshua";
  home.stateVersion = "24.05";

  home.sessionVariables = {
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";
    PYTHON_HISTORY = "${config.xdg.stateHome}/python/history";
    IPYTHONDIR = "${config.xdg.configHome}/ipython";
    XCURSOR_PATH = "/usr/share/icons:${config.xdg.dataHome}/icons";

    TERMINAL="${inputs.ghostty.packages.${pkgs.system}.default}/bin/ghostty";
  };

  home.shellAliases = {
    steam = "flatpak run com.valvesoftware.Steam";
  };

  gtk = {
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  xdg = {
    enable = true;
    userDirs.createDirectories = false;
  };

  xresources = {
    path = "${config.xdg.configHome}/x11/xresources";
  };
}
