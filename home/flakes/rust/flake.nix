{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable-small";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, rust-overlay }: let
    lib = nixpkgs.lib;
    forAllSystems = lib.genAttrs lib.systems.flakeExposed;
  in {
    devShells = forAllSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ (import rust-overlay) ];
      };
    in {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [
          openssl
          pkg-config
          rust-bin.stable.latest.default
        ];
      };
    });
  };
}
