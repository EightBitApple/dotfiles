{
  zramSwap = {
    enable = true;
    memoryPercent = 150;
  };

  # Tweaking the system's swap to take full advantage of zram.
  # https://wiki.archlinux.org/title/Zram#Optimizing_swap_on_zram
  # https://github.com/NixOS/nixpkgs/pull/351002
  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
  };
}
