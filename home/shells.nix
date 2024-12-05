{...}: {
  nix.registry = {
    python.to = {
      type = "path";
      path = "${./flakes/python}";
    };
    rust.to = {
      type = "path";
      path = "${./flakes/rust}";
    };
  };
}
