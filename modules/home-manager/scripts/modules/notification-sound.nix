{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.notificationSound.enable = lib.mkEnableOption ''
    Enable script to play notification sound. Intended to be used with notification daemons.
  '';

  config = lib.mkIf config.notificationSound.enable {
    home.packages = with pkgs; [
      (pkgs.writeShellApplication {
        name = "notif-sound";
        runtimeInputs = with pkgs; [ pipewire ];
        text = ''
          pw-play --volume 4 ~/.local/share/system-sounds/notification.ogg
        '';
      })
    ];
  };
}
