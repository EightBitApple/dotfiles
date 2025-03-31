{ userSettings, pkgs, ... }:

{
  services.emacs = {
    install = true;
    enable = true;
    startWithGraphical = true;
    package =
      with pkgs;
      ((emacsPackagesFor userSettings.emacs.package).emacsWithPackages (epkgs: [ epkgs.vterm ]));
  };
}
