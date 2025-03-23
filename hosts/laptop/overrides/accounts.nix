{ config, lib, userSettings, ... }:

{
  sops.secrets."passwords/laptop" = {
    neededForUsers = true;
  };

  users.users."${userSettings.username}" = {
    hashedPasswordFile = config.sops.secrets."passwords/laptop".path;

    extraGroups = lib.mkForce [
      "networkmanager"
      "video"
      "wheel"
      "wireshark"
    ];
  };
}
