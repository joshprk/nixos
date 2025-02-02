{
  config,
  pkgs,
  ...
}: {
  xdg = {
    enable = true;
    /*
    portal = rec {
      enable = true;
      configPackages = extraPortals;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];

      config.hyprland.default = [
        "hyprland"
        "gtk"
      ];
    };
    */
    mime.enable = true;
    mimeApps.enable = true;
    userDirs.createDirectories = false;
  };

  home.file = {
    ".icons/default/index.theme".enable = false;
    ".icons/${config.home.pointerCursor.name}".enable = false;
    ".themes/adw-gtk3".enable = false;
  };

  home.sessionVariables = {
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    ERRFILE = "${config.xdg.cacheHome}/x11/xsession-errors";
    XCOMPOSECACHE = "${config.xdg.cacheHome}/x11/xcompose";
    IPYTHONDIR = "${config.xdg.configHome}/ipython";
  };

  gtk.gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  xresources.path = "${config.xdg.configHome}/x11/resources";
}
