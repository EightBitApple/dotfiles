{ config, lib, ... }:

{
  imports = [
    ./battery-info.nix
    ./battery-status.nix
    ./bluetooth-disconnect.nix
    ./bluetooth-toggle.nix
    ./change-brightness.nix
    ./change-volume.nix
    ./change-wallpaper.nix
    ./image-edit.nix
    ./nix-shell.nix
    ./notif-sound.nix
    ./screenshot.nix
    ./system-actions.nix
  ];
}
