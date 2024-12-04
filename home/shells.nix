{...}: {
  nix.registry = {
    python.flake = ./flakes/python;
    rust.flake = ./flakes/rust;
  };
}
