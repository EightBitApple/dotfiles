{ config, lib, pkgs, pkgs-unstable, ... }:

{
  options.extra-utilities.enable = lib.mkEnableOption ''
    Install extra utilities.
  '';
  config = lib.mkIf config.extra-utilities.enable {
    home.packages = with pkgs; [
      keepassxc
      neofetch
      vrrtest
      pkgs-unstable.nh
      nix-output-monitor
      nvd
      gimp
      aspell
      aspellDicts.en
      imagemagick
      thunderbird
      texliveFull
      unzip
      libreoffice
      lm_sensors
    ];
  };
}
