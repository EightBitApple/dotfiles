{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:

{
  options.accounts.enable = lib.mkEnableOption ''
    Define a user account.
  '';

  config = lib.mkIf config.accounts.enable {
    users.users."${userSettings.username}" = {
      isNormalUser = true;
      description = "${userSettings.name}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "wireshark"
        "gamemode"
        "video"
      ];
      shell = pkgs.zsh;
    };
  };
}
