{ pkgs, ... }:

let
  icon = {
    path = "${pkgs.myPackages.oxylite-icon-theme}/share/icons/Oxylite/status/bluetooth-";
    active = "${icon.path}active.svg";
    inactive = "${icon.path}inactive.svg";
  };
in

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "bt-toggle";
      runtimeInputs = [
        bluez
        libnotify
        ripgrep
      ];
      text = ''
        if [ "$(bluetoothctl show | rg "Powered: no")" ]; then
            power_state="on"
            icon=${icon.active}
        else
            power_state="off"
            icon=${icon.inactive}
        fi

        bluetoothctl power "$power_state" > /dev/null &
        notify-send -i "$icon" -h string:x-canonical-private-synchronous:bluetooth "Bluetooth" "$power_state" -t 2000
      '';
    })
  ];
}
