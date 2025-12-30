{ config, lib, userSettings, ... }:

{
  sops.secrets."passwords/laptop" = {
    neededForUsers = true;
  };

  users.users."${userSettings.user.name}" = {
    hashedPasswordFile = config.sops.secrets."passwords/laptop".path;

    extraGroups = lib.mkForce [
      "networkmanager"
      "podman"
      "video"
      "wheel"
      "wireshark"
    ];
  };
}
