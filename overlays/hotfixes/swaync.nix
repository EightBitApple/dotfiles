let
  swaync = "swaynotificationcenter";
in

(final: prev: {
  ${swaync} = prev.${swaync}.overrideAttrs (old: {
    version = "0.12.3-hotfix";
    src = prev.fetchFromGitHub {
      owner = "ErikReider";
      repo = "SwayNotificationCenter";
      rev = "aafe626a183daf4105f20c42c68ba14655fbcdcb";
      hash = "sha256-SYsXzQZGgCuyabP/Ran1qgWCBkmBCLmrqih7bx0VPLs=";
    };
  });
})
