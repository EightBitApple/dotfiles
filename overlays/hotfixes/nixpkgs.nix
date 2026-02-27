# linux-manual: fix for Linux 6.19 #490939
# https://github.com/NixOS/nixpkgs/pull/490939
(final: prev: {
  linux-manual = prev.callPackage (prev.fetchurl {
    url = "https://raw.githubusercontent.com/illdefined/nixpkgs/5e4242bed338e0f2a0913f00dde1c6529e9294f6/pkgs/by-name/li/linux-manual/package.nix";
    hash = "sha256-DsfnI95dtZYpkereuW+oPD78quR5/FYmUOYylZiTAVE=";
  }) { };
})
