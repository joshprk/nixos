{
  pkgs,
  ...
}: {
  imports = [
    ./hypr.nix
    ./nvim.nix
    ./programs.nix
    ./xdg.nix
  ];

  home.username = "joshua";
  home.homeDirectory = "/home/joshua";
  home.stateVersion = "24.11";

  user = {
    hypr.enable = true;
    nvim.enable = true;
    programs.enable = true;
    xdg.enable = true;
  };
}
