{...}: {
  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
    ensureProfiles.profiles = {
      RUWireless = {
        connection = {
          id = "RUWireless";
          type = "wifi";
        };
        wifi = {
          ssid = "RUWireless Secure";
        };
        wifi-security = {
          key-mgmt = "wpa-eap";
        };
        "802-1x" = {
          eap = "ttls";
          phase2-auth = "pap";
        };
      };
    };
  };
}
