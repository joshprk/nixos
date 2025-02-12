{...}: {
  imports = [
    ./hypr.nix
    ./nvim.nix
    ./programs.nix
    ./services.nix
    ./stylix.nix
    ./waybar.nix
    ./xdg.nix
  ];

  home.username = "joshua";
  home.homeDirectory = "/home/joshua";
  home.stateVersion = "24.11";
}
