{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cemu
    dolphin-emu
    pcsx2
    retroarch
  ];
}
