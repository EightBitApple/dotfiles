{ lib, ... }:

{
  networking.dhcpcd.wait = "any";
}
