let
  system-key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKraOV94XHafhFwm4vfCMmhO7vg5Yq3djVZDvaUrwP4C";
in {
  "user.age".publicKeys = [system-key];
}
