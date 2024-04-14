{ config, lib, pkgs, ... }:

{
  options.swappiness-tweaks.enable = lib.mkEnableOption ''
    Tweaking the system's swap to take full advantage of zram.
    https://wiki.archlinux.org/title/Zram#Optimizing_swap_on_zram
  '';

  config = lib.mkIf config.swappiness-tweaks.enable {
    boot.kernel.sysctl = {
      "vm.swappiness" = 180;
      "vm.watermark_boost_factor" = 0;
      "vm.watermark_scale_factor" = 125;
      "vm.page-cluster" = 0;
    };
  };
}
