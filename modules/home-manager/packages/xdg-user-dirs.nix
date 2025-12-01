{ config, ... }:

let
  home = "${config.home.homeDirectory}";
in

{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    documents = "${home}/documents";
    download = "${home}/downloads";
    videos = "${home}/videos";
    music = "${home}/music";
    pictures = "${home}/pictures";
    publicShare = "${home}/public";
    desktop = null;
    templates = null;

    extraConfig = {
      XDG_DOTFILES_DIR = "${home}/dotfiles";
      XDG_MISC_DIR = "${home}/misc";
      XDG_SCREENSHOTS_DIR = "${home}/pictures/screenshots";
      XDG_WALLPAPERS_DIR = "${home}/pictures/wallpapers";
      XDG_CAPTURE_DIR = "${home}/videos/captures";
      XDG_VM_DIR = "${home}/vm";
    };
  };
}
