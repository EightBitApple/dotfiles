{ pkgs, ... }:

let
  icon = {
    path = "${pkgs.myPackages.oxylite-icon-theme}/share/icons/Oxylite/status/bluetooth-";
    aquiring = "${icon.path}acquiring.svg";
    disconnected = "${icon.path}disconnected.svg";
  };

  notif = {
    title = "Bluetooth Disconnect";
    hint = "string:x-canonical-private-synchronous:bluetooth_dev";
    time = "2000";
  };
in

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "bt-disconnect";
      runtimeInputs = [
        bluez
        libnotify
        ripgrep
        wofi
      ];
      text = ''
        devices=$(bluetoothctl devices Connected)
        if [ ! "$devices" ]; then
           notify-send -h ${notif.hint} -i ${icon.disconnected} -t ${notif.time} "${notif.title}" "No devices connected."
           exit 1
        fi

        choice=$(pkill wofi ; printf "%s" "$devices" | wofi -p "select device to disconnect:" --dmenu)
        [ ! "$choice" ] && exit 1

        # regex adapted from: https://stackoverflow.com/a/4260512
        choice=$(printf "%s" "$choice" | rg '(([0-9A-Fa-f]{2}[:]){5}[0-9A-Fa-f]{2})' -or '$1')

        notify-send -h ${notif.hint} -i ${icon.aquiring} "${notif.title}" "Attempting to disconnect $choice" &
        bluetoothctl disconnect "$choice" > /dev/null
        notify-send -h ${notif.hint} -i ${icon.disconnected} -t ${notif.time} "${notif.title}" "Disconnected $choice"
      '';
    })
  ];
}
