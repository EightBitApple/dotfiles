let
  swaync = "swaynotificationcenter";
in

(final: prev: {
  ${swaync} = prev.${swaync}.overrideAttrs (old: {
    version = "0.12.4-hotfix";
    src = prev.fetchFromGitHub {
      # Commit 5228963: Bumped version to v0.12.4
      owner = "ErikReider";
      repo = "SwayNotificationCenter";
      rev = "5228963a0dccbee558e153491eb067bd8a053937";
      hash = "sha256-W4d41+qFT+4Vfpx/v77DuiumQ8mzl6g+PCIJZ+Py1Po=";
    };
  });
})
