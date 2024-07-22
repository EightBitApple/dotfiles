{ config, lib, ... }:

{

  options.network.enable = lib.mkEnableOption ''
    Enable and configure Network Manager.
  '';
  config = lib.mkIf config.network.enable {
    networking = {
      networkmanager.enable = true;
      hostName = "nixos";
    };
  };
}
