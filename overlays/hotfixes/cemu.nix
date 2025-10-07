{ lib, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      cemu = prev.cemu.overrideAttrs (old: {
        cmakeFlags = [
          (lib.cmakeFeature "CMAKE_C_FLAGS_RELEASE" "-DNDEBUG")
          (lib.cmakeFeature "CMAKE_CXX_FLAGS_RELEASE" "-DNDEBUG")
          (lib.cmakeBool "ENABLE_VCPKG" false)
          (lib.cmakeBool "ENABLE_FERAL_GAMEMODE" true)

          # Fix building v2.6, should be removed in the future
          "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"

          # PORTABLE: "All data created and maintained by Cemu will be in
          # the directory where the executable file is located"
          (lib.cmakeBool "PORTABLE" false)
        ];
      });
    })
  ];
}
