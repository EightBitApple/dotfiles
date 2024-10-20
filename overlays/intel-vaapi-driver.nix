(final: prev: {
  intel-vaapi-driver = prev.intel-vaapi-driver.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      (prev.fetchpatch {
        url = "https://patch-diff.githubusercontent.com/raw/intel/intel-vaapi-driver/pull/566.patch";
        hash = "sha256-unCnAGM36sRcW4inaN21IqVOhHY9YB+iJYGgdFCxWQ0=";
      })
    ];
  });
})
