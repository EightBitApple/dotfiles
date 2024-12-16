{ config, lib, ... }:

{
  imports = [
    ./modules/battery-status.nix
    ./modules/battery-info.nix
    ./modules/change-volume.nix
    ./modules/change-brightness.nix
    ./modules/system-actions.nix
    ./modules/screenshot.nix
    ./modules/image-edit.nix
    ./modules/notification-sound.nix
  ];
}
