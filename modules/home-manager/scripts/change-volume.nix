{ pkgs, ... }:

let
  icon = {
    path = "${pkgs.myPackages.oxylite-icon-theme}/share/icons/Oxylite/status/audio-volume-";

    mute = "${icon.path}muted.svg";
    low = "${icon.path}low.svg";
    mid = "${icon.path}medium.svg";
    high = "${icon.path}high.svg";
    over = "${icon.path}overamplified.svg";
  };

  pamixer = "${pkgs.pamixer}/bin/pamixer";
  wpctl = "${pkgs.wireplumber}/bin/wpctl";
in

{
  home.packages = with pkgs; [
    (pkgs.writeShellScriptBin "change-volume" ''
      notif_time=500

      notify() {
          vol="$(${pamixer} --get-volume)"

          case 1 in
              $((vol > 100)) ) icon="${icon.over}" ;;
              $((vol >= 70)) ) icon="${icon.high}" ;;
              $((vol >= 30)) ) icon="${icon.mid}" ;;
              $((vol > 0)) ) icon="${icon.low}" ;;
              $((vol == 0)) ) icon="${icon.mute}" ;;
          esac

          notify-send -u low -i "$icon" "volume" "$vol%" -h string:x-canonical-private-synchronous:volume -t "$notif_time"
      }

      vol_inc=$2
      vol_limit=1.25

      case $1 in
      mute)
          ${pamixer} --toggle-mute
          if "$(${pamixer} --get-mute)"; then
              notify-send -u low -i "${icon.mute}" "volume" "muted" -h string:x-canonical-private-synchronous:volume -t "$notif_time"
          else
              notify
          fi
          exit 0
          ;;
      up) arg="+" ;;
      down) arg="-" ;;
      esac

      ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ 0
      ${wpctl} set-volume -l "$vol_limit" @DEFAULT_AUDIO_SINK@ "$vol_inc"%"$arg"
      notify
    '')
  ];
}
