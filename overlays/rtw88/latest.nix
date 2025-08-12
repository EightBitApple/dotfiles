{ systemSettings, ... }:

let
  driver = systemSettings.overlays.rtw88;
in

{
  nixpkgs.overlays = [
    (final: prev: {
      linuxPackages_latest = prev.linuxPackages_latest.extend (
        lpfinal: lpprev: {
          rtw88 = prev.linuxPackages_latest.rtw88.overrideAttrs (old: {
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
