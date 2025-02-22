(final: prev: {
  iconpack-obsidian = prev.iconpack-obsidian.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "EightBitApple";
      repo = "iconpack-obsidian";
      rev = "b4d3d75724f48a8d1f22a46a52ce324362487ff3";
      sha256 = "7G2XDS49CZgQqbnUADHWyw9Ko8kGuFkFWc0fqHR7xgE=";
    };
  });
})
