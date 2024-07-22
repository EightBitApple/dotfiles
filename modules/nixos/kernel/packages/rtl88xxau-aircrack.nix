{ config, lib, ... }:

{
  options.rtl88xxau-aircrack.enable = lib.mkEnableOption ''
    Use the 'rtl88xxau-aircrack' kernel module for 88XXau Realtek chipsets. USB network adapters only.
  '';

  config = lib.mkIf config.rtl88xxau-aircrack.enable {
    boot.extraModulePackages = with config.boot.kernelPackages; [ rtl88xxau-aircrack ];
  };
}
