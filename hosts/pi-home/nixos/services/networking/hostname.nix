{ lib, ... }:

{
  networking.hostName = lib.mkForce "pi-home";
}
