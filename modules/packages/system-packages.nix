{ config, lib, pkgs, ... }:

{
  options.system-packages.enable = lib.mkEnableOption ''
    Install system packages.
  '';

  config = lib.mkIf config.system-packages.enable {
    environment.systemPackages = with pkgs; [
      wget
      ripgrep
      fd
      gnumake
      home-manager
    ];
  };
}
