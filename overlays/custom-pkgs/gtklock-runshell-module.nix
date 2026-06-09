{
  fetchFromGitLab,
  lib,
  meson,
  ninja,
  gtk3,
  pkg-config,
  stdenv,
  ...
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "gtklock-runshell-module";
  version = "4.0.0";

  src = fetchFromGitLab {
    owner = "wef";
    repo = "${finalAttrs.pname}";
    tag = "${finalAttrs.version}";
    hash = "sha256-aVB8e+kk/jNxIJsHdeNxvNqqrV9ThcO9nHtj/gJ6/is=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
  ];

  buildInputs = [ gtk3 ];

  meta = {
    description = "Gtklock module to add output from a script to the lockscreen.";
    homepage = "https://gitlab.com/wef/gtklock-runshell-module";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
})
