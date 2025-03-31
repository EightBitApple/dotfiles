{ pkgs, userSettings, ... }:

{
  users.users."${userSettings.user.name}" = {
    isNormalUser = true;
    description = "${userSettings.user.fullName}";
    extraGroups = [
      "networkmanager"
      "wheel"
      "wireshark"
      "gamemode"
      "video"
    ];
    shell = pkgs.zsh;
  };
}
