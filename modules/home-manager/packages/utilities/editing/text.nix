{ pkgs, ... }:

{
  home.packages = with pkgs; [
    aspell
    aspellDicts.en
    libreoffice
    texliveFull
  ];
}
