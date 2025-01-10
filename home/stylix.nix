{
  config,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/kx/wallhaven-kx9ql7.jpg";
      sha256 = "sha256-D0P9pTc5LVheYuhzTg1w9cUdK2TjsJf+tKn6Diwdxss=";
    };
    cursor = {
      name = "catppuccin-mocha-dark-cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
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
    };
  };
}
