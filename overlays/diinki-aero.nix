{ stdenvNoCC, lib, fetchFromGitHub, ... }:

stdenvNoCC.mkDerivation rec {
  pname = "diinki-aero";
  version = "1.0";
  src = fetchFromGitHub {
    owner = "EightBitApple";
    repo = "${pname}";
    rev = "b4021546e24cc80d8f218318a136b3248d79e793";
    hash = "sha256-29iPaO2yscIrHtBk+rGIieqU1Fh9+vlRCcFKv0X4H4w";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/themes/diinki-aero
    cp -a GTKTheme/diinki-aero/* $out/share/themes/diinki-aero

    mkdir -p $out/share/icons/crystal-remix-icon-theme-diinki-version
    cp -a IconTheme/crystal-remix-icon-theme-diinki-version/* $out/share/icons/crystal-remix-icon-theme-diinki-version
    runHook postInstall
  '';
}
