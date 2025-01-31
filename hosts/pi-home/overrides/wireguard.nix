{ config, ... }:

{
  networking.nat = {
    enable = true;
    externalInterface = "wlp3s0";
    internalInterfaces = [ "wg0" ];
  };
}
