{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.extra-utilities.enable = lib.mkEnableOption ''
    Install extra utilities.
  '';
  config = lib.mkIf config.extra-utilities.enable {
    home.packages = with pkgs; [
      keepassxc
      fastfetch
      vrrtest
      nh
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
      appimage-run
      file-roller
      home-manager
    ];
  };
}
