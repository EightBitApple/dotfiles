{ systemSettings, ... }:

let
  driver = systemSettings.overlays.rtw88;
in

{
  nixpkgs.overlays = [
    (final: prev: {
      linuxPackages = prev.linuxPackages.extend (
        lpfinal: lpprev: {
          rtw88 = prev.linuxPackages.rtw88.overrideAttrs (old: {
            version = driver.version;
            src = prev.fetchFromGitHub {
              owner = driver.owner;
              repo = driver.repo;
              rev = driver.rev;
              hash = driver.hash;
            };
          });
        }
      );
    })
  ];
}
