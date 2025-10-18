let
  swaync = "swaynotificationcenter";
in

{
  nixpkgs.overlays = [
    (final: prev: {
      ${swaync} = prev.${swaync}.overrideAttrs (old: rec {
        pname = "${swaync}-hotfix";
        src = prev.fetchFromGitHub {
          owner = "ErikReider";
          repo = "SwayNotificationCenter";
          rev = "3e83f1f471dd9c1d91a60c150e9b76da0a8c3fc7";
          hash = "sha256-7phV4sYLQJKX2hi5bmT6gAgc4aKKfCk8lERlMNRv6HM=";
        };
      });
    })
  ];
}
