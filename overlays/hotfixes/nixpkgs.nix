# searxng: fix 2026-01-11 relaxing markdown-it-py
# https://github.com/NixOS/nixpkgs/pull/483247
(final: prev: {
  searxng = prev.callPackage (prev.fetchurl {
    url = "https://raw.githubusercontent.com/svistoi/nixpkgs/ddec51db1ebc3ad1ebab693db764c97dcc034706/pkgs/by-name/se/searxng/package.nix";
    hash = "sha256-7nArinbuRfJ3/dWYJz/JvqkZ/26PUA3kJWNTQR2B9L4=";
  }) { };
})
