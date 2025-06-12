{ config, lib, ... }:

{
  imports = [
    ./modules/battery-info.nix
    ./modules/battery-status.nix
    ./modules/bluetooth-disconnect.nix
    ./modules/bluetooth-toggle.nix
    ./modules/change-brightness.nix
    ./modules/change-volume.nix
    ./modules/change-wallpaper.nix
    ./modules/image-edit.nix
    ./modules/notif-sound.nix
    ./modules/screenshot.nix
    ./modules/system-actions.nix
  ];
}
