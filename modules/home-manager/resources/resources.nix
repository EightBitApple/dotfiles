{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.resources.enable = lib.mkEnableOption ''
    Enable the use of resources.
  '';

  config = lib.mkIf config.resources.enable {
    home.file = {
      ".local/share/soundfonts".source = ./content/soundfonts;
      ".local/share/wallpapers".source = ./content/wallpapers;
      ".local/share/system-sounds".source = ./content/system-sounds;
    };
  };
}
