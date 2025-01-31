{ config, userSettings, ... }:

{
  sops.secrets."passwords/desktop" = {
    neededForUsers = true;
  };

  users.users."${userSettings.username}" = {
    hashedPasswordFile = config.sops.secrets."passwords/desktop".path;
  };
}
