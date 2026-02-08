{ config, lib, ... }:

let
  hdd = "${config.home.homeDirectory}/hdd";
  force = lib.mkForce;
in

{
  xdg.userDirs = {
    download = force "${hdd}/downloads";
    music = force "${hdd}/music";
    pictures = force "${hdd}/pictures";

    videos = force "${hdd}/videos";
    extraConfig.capture = force "${hdd}/videos/captures";
  };
}
