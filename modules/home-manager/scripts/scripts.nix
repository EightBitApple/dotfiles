{ config, lib, ... }:

{
  options.scripts.enable = lib.mkEnableOption ''
    Enable the use of scripts.
  '';
  imports = [
    ./modules/battery-status.nix
    ./modules/battery-info.nix
    ./modules/change-volume.nix
    ./modules/change-brightness.nix
    ./modules/system-actions.nix
    ./modules/screenshot.nix
    ./modules/image-edit.nix
    ./modules/notification-sound.nix
    ./modules/wallpaper-tod.nix
  ];

  config = lib.mkIf config.scripts.enable {
    changeVolume.enable = lib.mkDefault true;
    changeBrightness.enable = lib.mkDefault true;
    systemActions.enable = lib.mkDefault true;
    screenshot.enable = lib.mkDefault true;
    imageEdit.enable = lib.mkDefault true;
    notificationSound.enable = lib.mkDefault true;
    wallpaperTod.enable = lib.mkDefault true;
    batteryStatus.enable = lib.mkDefault true;
    batteryInfo.enable = lib.mkDefault true;
  };
}
