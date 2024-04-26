{ config, lib, pkgs, ... }:

{
  options.microcode-updates.enable = lib.mkEnableOption ''
    Enable microcode updates for both Intel and AMD CPUs.
  '';

  config = lib.mkIf config.microcode-updates.enable {
    hardware.cpu = {
      intel.updateMicrocode = true;
      amd.updateMicrocode = true;
    };
  };
}
