let
  ssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHm7m7TJ5xzqsD4cC2ACFwCBE5LBQdn0RG1+ov4E3JTY joshua@PC";
in {
  "user.age".publicKeys = [ssh];
  "tailscale.age".publicKeys = [ssh];
}
