{
  config,
  lib,
  pkgsOverlay,
  ...
}:

{
  options.intelHwdec.enable = lib.mkEnableOption ''
    Enable GPU accelerated video encoding and decoding for Intel graphics.
  '';

  config = lib.mkIf config.intelHwdec.enable {
    hardware.graphics = {
      enable = true;
      extraPackages = [ pkgsOverlay.intel-vaapi-driver ];
    };

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "i965";
    }; # Force intel-vaapi-driver (older but works better for Firefox/Chromium)
  };
}
