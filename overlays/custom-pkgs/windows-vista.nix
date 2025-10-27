{
  stdenvNoCC,
  lib,
  pkgs,
  fetchFromGitHub,
  ...
}:

stdenvNoCC.mkDerivation rec {
  pname = "Windows-Vista";
  version = "1.0";
  src = fetchFromGitHub {
    owner = "B00merang-Project";
    repo = "${pname}";
    tag = "${version}";
    hash = "sha256-oOXXEVPNcmqylHXy/JL0fGq+aRpTQ4siQnZMxakhXKY=";
  };

  installPhase = ''
    mkdir -p $out/share/themes/${pname}
    cp -a * $out/share/themes/${pname}
  '';
}
