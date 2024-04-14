{ config, lib, pkgs, ... }:

{
  options.steam.enable = lib.mkEnableOption ''
    Enable the use of Steam and fetch the latest version of Proton-GE.
  '';

  config = lib.mkIf config.steam.enable {
    programs.steam = {
      enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };
  };
}
