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
    rev = "79e0ed0fc1ab05d30b7d93c321d3c14649348155";
    hash = "sha256-8ev6RYuVNeDpOD01Gt1qctb+wfys/lL+p6ROdRJWJRo=";
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
