{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "notif-sound";
      runtimeInputs = [ pipewire ];
      text = builtins.readFile ../scripts/notification-sound.sh;
    })
  ];
}
