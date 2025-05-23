{ pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "options"
      "thinkpad_acpi"
      "fan_control=1"
    ];
  };
}
