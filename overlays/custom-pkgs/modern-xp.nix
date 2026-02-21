{ stdenvNoCC, pkgs, ... }:

let
  name = "ModernXP";
in

stdenvNoCC.mkDerivation rec {
  pname = "modern-xp-cursor-theme";
  version = "1.0.1";

  src = fetchTarball {
    url = "https://github.com/na0miluv/modernXP-cursor-theme/releases/download/final/ModernXP.tar.gz";
    sha256 = "sha256:1s5cx93vq3l1yqm70vvxqbc7jsmsg4kv74z7gimb204hvs1ghwfj";
  };

  installPhase = ''
    mkdir -p $out/share/icons/${name}
    cp -a * $out/share/icons/${name}
  '';
}
