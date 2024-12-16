{ pkgs, userSettings, ... }:

{
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
}
