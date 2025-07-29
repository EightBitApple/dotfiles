{
  nixpkgs.overlays = [
    (final: prev: {
      wofi = prev.wofi.overrideAttrs (old: {
        version = "1.5-hotfix";
        src = prev.fetchFromSourcehut {
          repo = "wofi";
          owner = "~scoopta";
          rev = "cf90b7608efcbdd209f9e8652399e551900fbb18";
          hash = "sha256-ZLObrugm9YTyJgRQWYHShSaASJYVu1J4bRhuzPsKedE=";
          vc = "hg";
        };
      });
    })
  ];
}
