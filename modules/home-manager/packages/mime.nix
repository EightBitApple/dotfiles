{ config, lib, ... }:

{
  options.mine.enable = lib.mkEnableOption ''
    Configure MIME.
  '';

  config = lib.mkIf config.mime.enable {
    xdg.mimeApps.defaultApplications = {
      "text/plain" = [ "emacsclient.desktop" ];
      "application/pdf" = [ "zathura.desktop" ];
      "image/*" = [ "sxiv.desktop" ];
      "video/png" = [ "mpv.desktop" ];
      "video/jpg" = [ "mpv.desktop" ];
      "video/*" = [ "mpv.desktop" ];
    };
  };
}
