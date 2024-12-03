{...}: {
  services.openssh = {
    enable = true;
    startWhenNeeded = true;

    settings = {
      PasswordAuthentication = false;
    };
  };
}
