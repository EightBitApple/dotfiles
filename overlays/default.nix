{ pkgs, ... }:

let
  mpvScripts = with pkgs.mpvScripts; [
    sponsorblock
    mpv-playlistmanager
    quality-menu
  ];
in
{
  nixpkgs.overlays = [
    (final: prev: {
      myPackages = {
        diinki-aero = pkgs.callPackage ./diinki-aero.nix { };
      };
    })

    (final: prev: {
      linuxPackages_latest = prev.linuxPackages_latest.extend (
        lpfinal: lpprev: {
          rtw88 = prev.linuxPackages_latest.rtw88.overrideAttrs (old: {
            version = "0-unstable-2025-05-08";
            src = prev.fetchFromGitHub {
              owner = "lwfinger";
              repo = "rtw88";
              rev = "461b696b51317ba4ca585a4ddb32f2e72cd4efc9";
              hash = "sha256-PBAON2s7gKvpO40vppahEtkWJ4HIjbOjfUz+fx87gIA=";
            };
          });
        }
      );
    })

    (final: prev: { mpv = prev.mpv.override { scripts = mpvScripts; }; })
  ];
}
