{ lib, userSettings, ... }:

{
  networking.hostName = lib.mkForce "desktop";
  imports = [ ./hardware-configuration.nix ];

  disabledModules = [
    ../../modules/nixos/hardware/brillo.nix
    ../../modules/nixos/hardware/intel-hwdec.nix
    ../../modules/nixos/services/device/printing.nix
    ../../modules/nixos/services/device/tlp.nix
  ];
}
