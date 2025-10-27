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
  version = "v1.1.6";

  src = fetchFromGitHub {
    owner = "mx-2";
    repo = "${pname}";
    tag = "v${version}";
    hash = "sha256-e/aUnF8I/m7MrkRbhQEUstmRq0MURrgs0PsF+ID0SNk=";
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
