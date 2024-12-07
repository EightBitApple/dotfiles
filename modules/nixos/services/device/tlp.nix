{ config, lib, ... }:

{
  options.tlp.enable = lib.mkEnableOption ''
    Enable and configure the tlp power management service.
  '';

  config = lib.mkIf config.tlp.enable {
    services.tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 80;

        START_CHARGE_THRESH_BAT1 = 75;
        STOP_CHARGE_THRESH_BAT1 = 80;

        RUNTIME_PM_ON_AC = "auto";
        RUNTIME_PM_ON_BAT = "auto";

        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

        WIFI_PWR_ON_AC = "on";
        WIFI_PWR_ON_BAT = "on";
      };
    };
    services.power-profiles-daemon.enable = false;
  };
}
