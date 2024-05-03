{ config, lib, pkgs, ... }:

{
  options.extra-utilities.enable = lib.mkEnableOption ''
    Install extra utilities.
  '';
  config = lib.mkIf config.extra-utilities.enable {
    home.packages = with pkgs; [
      keepassxc
      neofetch
      vrrtest
      nh
      nix-output-monitor
      nvd
      gimp
      ispell
      imagemagick
      thunderbird
      texliveMedium
      unzip
    ];
  };
}
