{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
    lanzaboote.url = "github:nix-community/lanzaboote";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:fufexan/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
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
    getPkgs = system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    mkSystem = {
      hostName,
      system,
      stateVersion,
      extraModules,
    }: let
      pkgs = getPkgs system;
    in
      lib.nixosSystem {
        inherit system;
        specialArgs =
          {
            inherit pkgs system;
          }
          // self.inputs;
        modules = with self.inputs;
          [
            {networking.hostName = hostName;}
            {system.stateVersion = stateVersion;}

            (
              {config, ...}: {
                users.users.root.hashedPasswordFile = config.age.secrets.user.path;
                home-manager = {
                  extraSpecialArgs = self.inputs;
                  sharedModules = [
                    nixvim.homeManagerModules.nixvim
                    stylix.homeManagerModules.stylix
                  ];
                };

                nix.settings.trusted-substituters = [
                  "https://cache.nixos.org/"
                  "https://nix-community.cachix.org"
                  "https://cuda-maintainers.cachix.org"
                ];

                nix.settings.trusted-public-keys = [
                  "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                  "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                  "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
                ];
              }
            )

            ./hardware/${lib.strings.toLower hostName}.nix
            ./hosts/${lib.strings.toLower hostName}.nix
            ./secrets

            impermanence.nixosModules.impermanence
            lanzaboote.nixosModules.lanzaboote
            home-manager.nixosModules.home-manager
            agenix.nixosModules.default
          ]
          ++ extraModules;
      };
  in {
    nixosConfigurations = {
      PC = mkSystem {
        hostName = "PC";
        system = "x86_64-linux";
        stateVersion = "24.05";
        extraModules = [
          ./modules/impermanence.nix
          ./modules/networking.nix
          ./modules/home.nix
          ./modules/hypr.nix
          ./modules/fwupd.nix
          ./modules/flatpak.nix
          ./modules/nvidia.nix
          ./modules/secureboot.nix
          ./modules/sshd.nix
        ];
      };

      LT = mkSystem {
        hostName = "LT";
        system = "x86_64-linux";
        stateVersion = "24.05";
        extraModules = [
          ./modules/impermanence.nix
          ./modules/networking.nix
          ./modules/home.nix
          ./modules/hypr.nix
          ./modules/nvidia.nix
          ./modules/fwupd.nix
          ./modules/tailscale.nix
        ];
      };
    };

    devShells = forAllSystems (
      system: let
        pkgs = getPkgs system;
      in {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            self.inputs.agenix.packages.${system}.default
            self.inputs.ags.packages.${system}.default
            sbctl
            git
          ];
        };
      }
    );

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}
