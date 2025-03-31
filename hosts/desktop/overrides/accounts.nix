{ config, userSettings, ... }:

{
  sops.secrets."passwords/desktop" = {
    neededForUsers = true;
  };

  users.users."${userSettings.user.name}" = {
    hashedPasswordFile = config.sops.secrets."passwords/desktop".path;
  };
}
