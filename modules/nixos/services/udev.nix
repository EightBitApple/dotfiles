{ config, lib, pkgs, ... }:

{
  options.udev.enable = lib.mkEnableOption ''
    Enable udev and custom rules.
  '';

  config = lib.mkIf config.udev.enable {
    services.udev = {
      enable = true;
      extraRules = ''
        # Disable DS4 touchpad acting as mouse
        # USB
        ATTRS{name}=="Sony Interactive Entertainment Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
        # Bluetooth
        ATTRS{name}=="Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
      '';
    };
  };
}
