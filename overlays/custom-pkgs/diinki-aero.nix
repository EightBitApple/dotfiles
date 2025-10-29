{
  stdenvNoCC,
  lib,
  fetchFromGitHub,
  ...
}:

stdenvNoCC.mkDerivation rec {
  pname = "diinki-aero";
  version = "1.0";
  src = fetchFromGitHub {
    owner = "EightBitApple";
    repo = "${pname}";
    rev = "e7acac51a8351352db88830da05de75eeb5d53b7";
    hash = "sha256-hWXrZuz9XEvKDwskUJdT98o9UqkrLVaCM6SuEUz+glE=";
  };

  installPhase = ''
    mkdir -p $out/share/themes/Diinki-Aero
    cp -a * $out/share/themes/Diinki-Aero
  '';
}
