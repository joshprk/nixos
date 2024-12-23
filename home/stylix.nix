{
  config,
  lib,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    polarity = "dark";
    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/3l/wallhaven-3lv8j6.jpg";
      sha256 = "sha256-Ed1FWLkTjncyux4RaQ9UVLYamq604nrw0qYSlrXQfu8=";
    };

    cursor = {
      name = "catppuccin-macchiato-dark-cursors";
      package = pkgs.catppuccin-cursors.macchiatoDark;
      size = 24;
    };

    fonts = {
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = config.stylix.fonts.monospace;
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono NerdFont";
      };
    };

    targets = {
      nixvim.enable = false;
      hyprpaper.enable = lib.mkForce false;
    };
  };
}
