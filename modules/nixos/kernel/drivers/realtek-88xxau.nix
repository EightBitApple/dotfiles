{ config, ... }:

{
  boot.extraModulePackages = with config.boot.kernelPackages; [ rtw88 ];
}
