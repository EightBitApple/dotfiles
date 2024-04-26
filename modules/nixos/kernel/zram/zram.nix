{ config, lib, pkgs, ... }:

{
  options.zram.enable = lib.mkEnableOption
    "Enables zram and sets it to double that of physical RAM";

  config = lib.mkIf config.zram.enable {
    zramSwap = {
      enable = true;
      memoryPercent = 200;
    };
  };
}
