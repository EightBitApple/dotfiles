{ userSettings, ... }:

{
  fileSystems."/home/${userSettings.user.name}/hdd" = {
    device = "/dev/disk/by-id/ata-ST2000DM006-2DM164_Z4ZAGJ4R-part1";
    fsType = "ext4";
  };
}
