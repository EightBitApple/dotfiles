{ config, userSettings, ... }:

{
  sops.secrets."passwords/pi-home" = {
    neededForUsers = true;
  };

  # https://wiki.nixos.org/wiki/SSH_public_key_authentication
  users.users."${userSettings.username}" = {
    hashedPasswordFile = config.sops.secrets."passwords/pi-home".path;

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMAitZRkQhGULZ4579RVdc0VCQ9S2SEwQ5wHL6V9yplE ${userSettings.username}" # content of authorized_keys file
      # note: ssh-copy-id will add user@your-machine after the public key
      # but we can remove the "@your-machine" part
    ];

    extraGroups = [ "wheel" ];
  };
}
