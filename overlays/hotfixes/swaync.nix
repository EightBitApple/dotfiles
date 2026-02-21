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
      rev = "aafe626a183daf4105f20c42c68ba14655fbcdcb";
      hash = "sha256-SYsXzQZGgCuyabP/Ran1qgWCBkmBCLmrqih7bx0VPLs=";
    };
  });
})
