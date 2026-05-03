{
  # Skip openldap tests while only triggering rebuilds for packages that depend
  # on pkgsi686Linux.openldap. Allows Bottles to update while avoiding mass
  # rebuilds.
  # https://github.com/NixOS/nixpkgs/issues/513245#issuecomment-4320293674
  nixpkgs.overlays = [
    (_: prev: {
      openldap = prev.openldap.overrideAttrs {
        doCheck = !prev.stdenv.hostPlatform.isi686;
      };
    })
  ];
}
