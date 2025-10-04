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
    rev = "3c15b310c781397067e03b64e21cdae58a14bd88";
    hash = "sha256-eUvqSQYnwvzmj3xZJktusJg5+fbgLjHcot5vUNBQFuw=";
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
