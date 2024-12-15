{
  config,
  lib,
  inputs,
  systemSettings,
  ...
}:

{
  # Automatically update the system on a regular bases.

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
}
