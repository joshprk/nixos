{pkgs, ...}: {
  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];

  programs.hyprland = {
    enable = true;
  };

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = false;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
