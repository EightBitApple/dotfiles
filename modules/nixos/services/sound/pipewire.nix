{ config, lib, pkgs, ... }:

{
  options.pipewire.enable = lib.mkEnableOption ''
    Enable Pipewire with ALSA, Pulseaudio and JACK Support. Rekit will also be
    enabled to give Pipewire realtime piority.
  '';

  config = lib.mkIf config.pipewire.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
