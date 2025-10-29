{
  stdenvNoCC,
  lib,
  pkgs,
  fetchFromGitHub,
  ...
}:

let
  iconThemeName = "Oxylite";
in

stdenvNoCC.mkDerivation rec {
  pname = "oxylite-icon-theme";
  version = "dotfiles";

  src = fetchFromGitHub {
    owner = "EightBitApple";
    repo = "${pname}";
    rev = "19d5f57b06454444dcafe5cabb1586b86dd45865";
    hash = "sha256-lKQDSNe1cok7hwuZBfG25B2ShCkqi16zhYI3zWPvzGk=";
  };

  preConfigure = ''
    patchShebangs check_symlinks.sh
    patchShebangs check_svgs.sh
  '';

  installPhase = ''
    mkdir -p $out/share/icons/${iconThemeName}
    cp -a * $out/share/icons/${iconThemeName}
  '';
}
