{ userSettings, pkgs, ... }:

{
  services.emacs = {
    install = true;
    enable = true;
    startWithGraphical = true;
    package =
      with pkgs;
      ((emacsPackagesFor userSettings.emacsPkg).emacsWithPackages (epkgs: [ epkgs.vterm ]));
  };
}
