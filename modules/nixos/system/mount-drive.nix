{
  config,
  lib,
  userSettings,
  ...
}:

{
  fileSystems."/home/${userSettings.username}/hdd" = {
    device = "/dev/disk/by-uuid/5a4b6498-53ca-44cc-92ce-f62300e5e010";
    fsType = "ext4";
  };
}
