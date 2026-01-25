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
    rev = "815eb35ac427be692663d84c74e816231e7f9e56";
    hash = "sha256-j9S6zxuyLsAiWtq1SdKrhHdSSPBOE+MNZu+l7VhKwY0=";
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
