{ lib, ... }:

{
  networking.hostName = lib.mkForce "desktop";
}
