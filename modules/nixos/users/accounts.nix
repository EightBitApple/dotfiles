{ pkgs, userSettings, ... }:

{
  users.users."${userSettings.user.name}" = {
    isNormalUser = true;
    description = "${userSettings.user.fullName}";
    extraGroups = [
      "gamemode"
      "podman"
      "video"
      "wheel"
      "wireshark"
    ];
    shell = pkgs.bash;
  };
}
