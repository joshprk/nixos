{pkgs, ...}: {
  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];

  programs.hyprland = {
    enable = true;
  };

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "Hyprland";
        user = "joshua";
      };

      default_session = initial_session;
    };
  };

  services.xserver = {
    enable = true;
    excludePackages = [
      pkgs.xterm
    ];

    desktopManager.xterm.enable = false;
    displayManager.lightdm.enable = false;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  security.rtkit = {
    enable = true;
  };

  xdg.autostart.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
