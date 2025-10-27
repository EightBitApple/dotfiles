{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (pkgs.writeShellApplication {
      name = "obs-clip";
      text = ''
        icon="${pkgs.myPackages.oxylite-icon-theme}/share/icons/Oxylite/categories/applications-multimedia.svg"
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
