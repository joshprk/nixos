{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";

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
        specialArgs = {inherit pkgs system;} // self.inputs;
        modules = with self.inputs;
          [
            {networking.hostName = hostName;}
            {system.stateVersion = stateVersion;}
            ./hardware/${lib.strings.toLower hostName}.nix
            ./hosts/${lib.strings.toLower hostName}.nix
            ./secrets
            impermanence.nixosModules.impermanence
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

          ./modules/sshd.nix
        ];
      };
    };

    devShells = forAllSystems (system: let
      pkgs = getPkgs system;
    in {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [
          self.inputs.agenix.packages.${system}.default
          git
        ];
      };
    });

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}
