{ pkgs, ... }:

let
  icon.path = "${pkgs.myPackages.oxylite-icon-theme}/share/icons/Oxylite/devices/video-display.svg";
in

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "display-mode";
      text = ''
        niri msg output "$1" mode "$2"@"$3" &
        notify-send -t 2000 -h string:x-canonical-private-synchronous:refresh -i ${icon.path} "Refresh Rate" "$(printf "%.0f\n" "$3")Hz"
      '';
    })
  ];
}
