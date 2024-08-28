{ config, lib, ... }:

{
  options.logind.enable = lib.mkEnableOption ''
    Set configuration for logind.
  '';

  config = lib.mkIf config.logind.enable {
    services.logind.extraConfig = ''
      NAutoVTs=0
      ReserveVT=1
    '';
  };
}
