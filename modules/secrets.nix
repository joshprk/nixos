{config, ...}: {
  fileSystems."/home".neededForBoot = true;
  age.identityPaths = ["/home/joshua/.ssh/sys_ed25519"];
  age.secrets = {
    user.file = ../secrets/user.age;
  };
}
