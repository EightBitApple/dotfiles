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
    services.easyeffects.enable = true;
    home.file.".config/easyeffects/output".source = ../../resources/content/easyeffects-presets/output;

    home.packages = with pkgs; [
      pulsemixer
      pamixer
      qpwgraph
      schismtracker
    ];
  };
}
