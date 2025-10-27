{ pkgs, ... }:

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
        icon=${pkgs.myPackages.oxylite-icon-theme}/share/icons/Oxylite/devices/bluetooth.svg

        if [ "$(bluetoothctl show | rg "Powered: no")" ]; then
            power_state="on"
        else
            power_state="off"
        fi

        bluetoothctl power "$power_state" > /dev/null &
        notify-send -i "$icon" -h string:x-canonical-private-synchronous:bluetooth "Bluetooth" "$power_state" -t 2000
      '';
    })
  ];
}
