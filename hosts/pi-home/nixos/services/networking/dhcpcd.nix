{ lib, ... }:

{
  networking.dhcpcd.wait = lib.mkForce "any";
}
