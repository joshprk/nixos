{...}: {
  age.identityPaths = [
    "/home/joshua/.ssh/sys_ed25519"
  ];

  age.secrets = {
    user.file = ./user.age;
  };
}
