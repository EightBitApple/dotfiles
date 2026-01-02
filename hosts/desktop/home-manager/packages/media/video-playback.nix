{ lib, ... }:

{
  programs.mpv.config.ytdl-format = lib.mkForce "bestvideo[vcodec^=vp9][height<=1440]+bestaudio";
}
