{ stdenvNoCC, lib, fetchFromGitHub, ... }:

stdenvNoCC.mkDerivation rec {
  pname = "diinki-aero";
  version = "1.0";
  src = fetchFromGitHub {
    owner = "EightBitApple";
    repo = "${pname}";
    rev = "e44fe71fa832cc62f39e075f0a4d72d820fbe63e";
    hash = "sha256-mFgBcfzzDXj8Nz0uX0OJLGFtaEvTuC7/ScIFgNpzqC4=";
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
