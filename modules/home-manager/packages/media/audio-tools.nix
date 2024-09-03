{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.audioTools.enable = lib.mkEnableOption ''
    Install software to manipulate audio playback.
  '';

  config = lib.mkIf config.audioTools.enable {
    home.packages = with pkgs; [
      pulsemixer
      pamixer
      qpwgraph
      schismtracker
    ];
  };
}
