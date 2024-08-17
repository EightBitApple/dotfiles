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
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        (intel-vaapi-driver.overrideAttrs {
          src = fetchFromGitHub {
            owner = "intel";
            repo = "intel-vaapi-driver";
            rev = "4206d0e15363d188f30f2f3dbcc212fef206fc1d";
            hash = "sha256-kbasiVOz9eHbO87SEuVMDT2pK5ouiVGglL+wcFJH9IM=";
          };
        })
      ];
    };

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "i965";
    }; # Force intel-vaapi-driver (older but works better for Firefox/Chromium)
  };
}
