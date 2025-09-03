{ userSettings, ... }:

{
  fileSystems."/home/${userSettings.user.name}/hdd" = {
    label = "HDD";
    fsType = "ext4";
    options = [ "x-systemd-automount" ];
  };
}
