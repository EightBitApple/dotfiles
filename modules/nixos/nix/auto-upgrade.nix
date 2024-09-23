{
  config,
  lib,
  inputs,
  systemSettings,
  ...
}:

{
  options.autoUpgrade.enable = lib.mkEnableOption ''
    Automatically update the system on a regular bases.
  '';

  config = lib.mkIf config.autoUpgrade.enable {
    system.autoUpgrade = {
      enable = true;
      flake = inputs.self.outPath;
      flags = [
        "--no-write-lock-file"
        "--recreate-lock-file"
        "-L" # print build logs
      ];
      dates = "${systemSettings.maintenanceDay}";
      randomizedDelaySec = "45min";
    };
  };
}
