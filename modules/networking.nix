{...}: {
  networking.networkmanager = {
    enable = true;
    wifi.powersave = true;
    ensureProfiles.profiles = {};
  };
}
