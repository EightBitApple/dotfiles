{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "notif-sound";
      runtimeInputs = [ pipewire ];
      text = builtins.readFile ../scripts/notif-sound.sh;
    })
  ];
}
