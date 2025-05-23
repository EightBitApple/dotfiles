{ lib, ... }:

{
  networking.hostName = lib.mkForce "laptop";
}
