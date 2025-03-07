{ stdenvNoCC, lib, fetchFromGitHub, ... }:

stdenvNoCC.mkDerivation rec {
  pname = "diinki-aero";
  version = "1.0";
  src = fetchFromGitHub {
    owner = "diinki";
    repo = "${pname}";
    rev = "${version}";
    hash = "sha256-sOW8U3kWNThjh8q6Bl3UC02pLPtHmIG+BNZgWlL6Zos=";
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
