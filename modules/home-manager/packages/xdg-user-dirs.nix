{ config, ... }:

{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    documents = "${config.home.homeDirectory}/documents";
    download = "${config.home.homeDirectory}/downloads";
    videos = "${config.home.homeDirectory}/videos";
    music = "${config.home.homeDirectory}/music";
    pictures = "${config.home.homeDirectory}/pictures";
    publicShare = "${config.home.homeDirectory}/public";
    desktop = null;
    templates = null;

    extraConfig = {
      XDG_DOTFILES_DIR = "${config.home.homeDirectory}/dotfiles";
      XDG_MISC_DIR = "${config.home.homeDirectory}/misc";
      XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/pictures/screenshots";
      XDG_WALLPAPERS_DIR = "${config.home.homeDirectory}/pictures/wallpapers";
      XDG_CAPTURE_DIR = "${config.home.homeDirectory}/videos/captures";
      XDG_VM_DIR = "${config.home.homeDirectory}/vm";
    };
  };
}
