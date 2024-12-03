let
  ssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBCBom//Vs1SSCBq9JxLloFZEBmkrZ81utid4eg3PfTe joshua@PC";
in {
  "user.age".publicKeys = [ssh];
}
