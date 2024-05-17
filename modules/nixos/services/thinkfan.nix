{ config, lib, pkgs, ... }:

{
  options.thinkfan.enable = lib.mkEnableOption ''
    Enable the Thinkfan fan control program.
  '';

  config = lib.mkIf config.thinkfan.enable {
    services.thinkfan.enable = true;
    boot.kernelParams = [ "options" "thinkpad_acpi" "fan_control=1" ];
  };
}
