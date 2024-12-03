{...}: {
  age.identityPaths = [
    "/home/joshua/.ssh/id_ed25519"
  ];

  age.secrets = {
    user.file = ./user.age;
  };
}
