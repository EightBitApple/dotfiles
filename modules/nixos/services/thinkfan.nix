{ config, lib, pkgs, ... }:

{
  options.thinkfan.enable = lib.mkEnableOption ''
    Enable the Thinkfan fan control program.
  '';

  config = lib.mkIf config.thinkfan.enable {
    services.thinkfan = {
      enable = true;
      levels = [
        [ 0 0 55 ]
        [ 1 48 60 ]
        [ 2 50 61 ]
        [ 3 52 63 ]
        [ 4 56 65 ]
        [ 5 59 66 ]
        [ 6 63 69 ]
        [ 7 66 32767 ]
      ];
    };
    boot.kernelParams = [ "options" "thinkpad_acpi" "fan_control=1" ];
  };
}
