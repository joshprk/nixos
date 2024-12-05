{config, lib, pkgs, ...}: {
  imports = [
    ./programs.nix
    ./hypr.nix
    ./nvim.nix
    ./shells.nix
  ];

  home.username = "joshua";
  home.homeDirectory = "/home/joshua";
  home.stateVersion = "24.05";

  home.sessionVariables = {
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    PYTHON_HISTORY = "${config.xdg.stateHome}/python/history";
  };

  home.shellAliases = {
    steam = "flatpak run com.valvesoftware.Steam";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  xdg = {
    enable = true;
    userDirs.createDirectories = false;
  };
}
