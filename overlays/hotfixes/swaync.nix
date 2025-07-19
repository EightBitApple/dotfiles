{
  nixpkgs.overlays = [
    (final: prev: {
      swaynotificationcenter = prev.swaynotificationcenter.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "ErikReider";
          repo = "SwayNotificationCenter";
          tag = "v0.12.1";
          hash = "sha256-4DDlQRHG90ee4Tu9y0lkY6hZxhPFyJmacbWJMErfFlk=";
        };
      });
    })
  ];
}
