let
  pbm = "gtklock-powerbar-module";
in
{
  nixpkgs.overlays = [
    (final: prev: {
      gtklock = prev.gtklock.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [ ./gtklock/bullet-point.patch ];
      });
    })

    (final: prev: {
      ${pbm} = prev.${pbm}.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [ ./gtklock/powerbar.patch ];
      });
    })
  ];
}
