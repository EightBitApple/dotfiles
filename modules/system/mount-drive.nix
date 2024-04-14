{ config, lib, pkgs, ... }:

{
  options.mount-drive.enable = lib.mkEnableOption ''
    Mount hard drive to home dir on boot.
  '';

  config = lib.mkIf config.mount-drive.enable {
    fileSystems."/home/stefan/hdd" = {
      device = "/dev/disk/by-uuid/5a4b6498-53ca-44cc-92ce-f62300e5e010";
      fsType = "ext4";
    };
  };
}
