{...}: {
  networking.networkmanager = {
    enable = true;
    ensureProfiles.profiles = {}; 
  };
}
