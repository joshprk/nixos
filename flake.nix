{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    lib = nixpkgs.lib;
    forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    getPkgs = system: import nixpkgs {inherit system;};

    astal-overlay = system: (final: prev: {
      astal = self.packages.${system}.astal;
    });

    zen-overlay = system: (final: prev: {
      zen-browser = self.inputs.zen-browser.packages.${system}.zen-browser;
    });

    mkSystem = {
      hostName,
      system,
      stateVersion,
      extraModules,
    }: let
      home = with self.inputs; [
        nixvim.homeManagerModules.nixvim
        stylix.homeManagerModules.stylix
      ];
      overlays = [
        (astal-overlay system)
        (zen-overlay system)
      ];
    in
      lib.nixosSystem {
        inherit system;
        specialArgs =
          {
            inherit system;
            inherit home;
            inherit overlays;
            inherit hostName;
            inherit stateVersion;
            inherit extraModules;
          }
          // self.inputs;
        modules = with self.inputs; [
          impermanence.nixosModules.impermanence
          home-manager.nixosModules.home-manager
          lanzaboote.nixosModules.lanzaboote
          agenix.nixosModules.default

          ./hosts/${lib.strings.toLower hostName}.nix
          ./hardware/${lib.strings.toLower hostName}.nix
          ./modules/defaults.nix
          ./modules/secrets.nix
        ];
      };
  in {
    nixosConfigurations = {
      PC = mkSystem {
        hostName = "PC";
        system = "x86_64-linux";
        stateVersion = "24.11";
        extraModules = with self.inputs; [
          hardware.nixosModules.common-pc
          ./modules/impermanence.nix
          ./modules/secureboot.nix
          ./modules/networking.nix
          ./modules/nvidia.nix

          ./modules/hypr.nix
          ./modules/home.nix
          ./modules/gaming.nix

          ./modules/sshd.nix
          ./modules/sunshine.nix
        ];
      };

      LT = mkSystem {
        hostName = "LT";
        system = "x86_64-linux";
        stateVersion = "24.11";
        extraModules = with self.inputs; [
          hardware.nixosModules.lenovo-ideapad-16ahp9
          ./modules/impermanence.nix
          ./modules/secureboot.nix
          ./modules/networking.nix
          ./modules/nvidia.nix

          ./modules/hypr.nix
          ./modules/home.nix
          ./modules/gaming.nix

          ./modules/tailscale.nix
        ];
      };
    };

    devShells = forAllSystems (system: let
      agenix = self.inputs.agenix;
      pkgs = getPkgs system;
    in {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [
          agenix.packages.${system}.agenix
          sbctl
        ];
      };
    });

    packages = forAllSystems (system: let
      ags = self.inputs.ags;
      pkgs = getPkgs system;
    in {
      astal = ags.lib.bundle {
        inherit pkgs;
        src = ./astal;
        name = "astal";
        entry = "app.ts";
        gtk4 = false;
        extraPackages = with ags.packages.${system}; [
          apps
          auth
          battery
          hyprland
          notifd
          tray
        ];
      };
    });

    formatter = forAllSystems (system: let
      pkgs = getPkgs system;
    in
      pkgs.alejandra);
  };
}
