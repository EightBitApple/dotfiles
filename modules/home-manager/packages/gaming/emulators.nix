{ pkgs, ... }:

let
  retroarchWithCores = (pkgs.retroarch.withCores (cores: with cores; [
    blastem
    bsnes
    mesen
    mupen64plus
    swanstation
  ]));
in
{
  home.packages = with pkgs; [
    retroarchWithCores
    cemu
    dolphin-emu
    pcsx2
  ];
}
