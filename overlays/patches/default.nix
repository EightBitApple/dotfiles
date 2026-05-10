{
  nixpkgs.overlays = [
    (final: prev: {
      gtklock = prev.gtklock.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [ ./gtklock-bullet-point.patch ];
      });
    })
  ];
}
