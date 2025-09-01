{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (pkgs.writeShellApplication {
      name = "obs-clip";
      text = ''
        icon="${pkgs.myPackages.diinki-aero}/share/icons/crystal-remix-icon-theme-diinki-version/128x128/preferences/preferences-desktop-multimedia.png";
        isObsRunning() {
            pgrep obs >/dev/null && return 0 || return 1
        }

        notify() {
            notify-send -i "$icon" -t 3000 "$1" "$2"
        }

        startObs() {
            notify "OBS is not running." "Starting OBS and replay buffer..."
            obs --startreplaybuffer &
            sleep 5
            isObsRunning && notify "Replay buffer started." "Press Mod+s to save the buffer."
        }

        if ! isObsRunning; then
            startObs
        else
            notify "OBS Replay" "Clip saved!"
        fi
      '';
    })
  ];
}
