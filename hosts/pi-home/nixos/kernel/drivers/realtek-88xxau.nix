{ config, ... }:

{
  boot.extraModulePackages = with config.boot.kernelPackages; [ rtl88xxau-aircrack ];
}
