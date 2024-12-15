{ config, lib, ... }:

{
  # Set configuration for logind.

  services.logind.extraConfig = ''
    NAutoVTs=0
    ReserveVT=1
  '';
}
