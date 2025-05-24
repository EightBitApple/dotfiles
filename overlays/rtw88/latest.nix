{ systemSettings, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      linuxPackages_latest = prev.linuxPackages_latest.extend (
        lpfinal: lpprev: {
          rtw88 = prev.linuxPackages_latest.rtw88.overrideAttrs (old: {
            version = systemSettings.overlays.rtw88.version;
            src = prev.fetchFromGitHub {
              owner = systemSettings.overlays.rtw88.owner;
              repo = systemSettings.overlays.rtw88.repo;
              rev = systemSettings.overlays.rtw88.rev;
              hash = systemSettings.overlays.rtw88.hash;
            };
          });
        }
      );
    })
  ];
}
