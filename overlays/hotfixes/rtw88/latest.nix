{ systemSettings, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      linuxPackages_latest = prev.linuxPackages_latest.extend (
        lpfinal: lpprev: {
          rtw88 = prev.linuxPackages_latest.rtw88.overrideAttrs (old: {
            version = "2025-08-09-hotfix";
            src = prev.fetchFromGitHub {
              owner = "lwfinger";
              repo = "rtw88";
              rev = "52072d874840f28c247b27f5d799f2c5c88a7e61";
              hash = "sha256-Lu3ol0iKfM9/SJ5lieh4A28h02Stc971ZypfiB2BWJ0=";
            };
          });
        }
      );
    })
  ];
}
