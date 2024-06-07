{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.intelHwdec.enable = lib.mkEnableOption ''
    Enable GPU accelerated video encoding and decoding for Intel graphics.
  '';

  config = lib.mkIf config.intelHwdec.enable {
    hardware.opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        libvdpau-va-gl
      ];
    };
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    }; # Force intel-media-driver
  };
}
