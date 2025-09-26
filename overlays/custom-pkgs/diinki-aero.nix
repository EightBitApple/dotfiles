{
  stdenvNoCC,
  lib,
  pkgs,
  fetchFromGitHub,
  ...
}:

stdenvNoCC.mkDerivation rec {
  pname = "diinki-aero";
  version = "1.0";
  src = fetchFromGitHub {
    owner = "EightBitApple";
    repo = "${pname}";
    rev = "cde69f77d12618052a49450b9006fdc98d8af25c";
    hash = "sha256-JT66hBuNzToKQBGJuxlvqJxQ5rRWevgSNQzpOMPqWbE=";
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
