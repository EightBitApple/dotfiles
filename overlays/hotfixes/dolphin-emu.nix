{ lib, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      dolphin-emu = prev.dolphin-emu.overrideAttrs (old: {
        cmakeFlags = [
          (lib.cmakeFeature "DISTRIBUTOR" "NixOS")
          (lib.cmakeFeature "DOLPHIN_WC_DESCRIBE" "2509")
          (lib.cmakeFeature "DOLPHIN_WC_BRANCH" "master")

          # Fix building v2509, should be removed in the future
          "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
        ]
        ++ lib.optionals prev.stdenv.hostPlatform.isDarwin [
          (lib.cmakeBool "OSX_USE_DEFAULT_SEARCH_PATH" true)
          (lib.cmakeBool "USE_BUNDLED_MOLTENVK" false)
          (lib.cmakeBool "MACOS_CODE_SIGNING" false)
          # Bundles the application folder into a standalone executable, so we cannot devendor libraries
          (lib.cmakeBool "SKIP_POSTPROCESS_BUNDLE" true)
          # Needs xcode so compilation fails with it enabled. We would want the version to be fixed anyways.
          # Note: The updater isn't available on linux, so we don't need to disable it there.
          (lib.cmakeBool "ENABLE_AUTOUPDATE" false)
        ];
      });
    })
  ];
}
