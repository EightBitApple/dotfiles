{ config, lib, ... }:

{
  options.xdgUserDirs.enable = lib.mkEnableOption ''
    Configure XDG user directories.
  '';

  config = lib.mkIf config.xdgUserDirs.enable {
    xdg.userDirs = {
      enable = true;
      createDirectories = true;

      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      videos = "${config.home.homeDirectory}/videos";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pictures";
      desktop = null;
      templates = null;
      publicShare = null;

      extraConfig = {
        XDG_MISC_DIR = "${config.home.homeDirectory}/misc";
      };
    };
  };
}
