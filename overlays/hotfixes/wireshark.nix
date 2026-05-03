# tshark: fix hash #515269
# https://github.com/NixOS/nixpkgs/pull/515269
(final: prev: {
  wireshark = prev.wireshark.overrideAttrs (old: {
    src = prev.fetchFromGitLab {
      repo = "wireshark";
      owner = "wireshark";
      tag = "v4.6.5";
      hash = "sha256-Zvrwxjp4LK2J3QnxmPxKKrU01YHQvPyp54UWzeGNCjA=";
    };
  });
})
