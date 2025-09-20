{
  imports = [
    ./hardware-configuration.nix
    ./nixos/drive-mounts.nix
    ./nixos/services/networking/network-manager.nix
    ./nixos/users/accounts.nix
  ];

  disabledModules = [
    ../../modules/nixos/hardware/brillo.nix
    ../../modules/nixos/hardware/intel-hwdec.nix
    ../../modules/nixos/services/device/printing.nix
    ../../modules/nixos/services/device/tlp.nix
    ../../modules/nixos/services/networking/access-point.nix
    ../../modules/nixos/services/networking/open-ssh.nix
    ../../modules/nixos/services/networking/wpa-supplicant.nix
    ../../modules/nixos/system/uboot.nix
  ];
}
