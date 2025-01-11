{...}: {
  imports = [
    ./hypr.nix
    ./nvim.nix
    ./programs.nix
    ./services.nix
    ./stylix.nix
    ./xdg.nix
  ];

  home.username = "joshua";
  home.homeDirectory = "/home/joshua";
  home.stateVersion = "24.11";
}
