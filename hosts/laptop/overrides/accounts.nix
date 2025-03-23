{ config, userSettings, ... }:

{
  sops.secrets."passwords/laptop" = {
    neededForUsers = true;
  };

  users.users."${userSettings.username}" = {
    hashedPasswordFile = config.sops.secrets."passwords/laptop".path;

    extraGroups = [
      "networkmanager"
      "video"
      "wheel"
      "wireshark"
    ];
  };
}
