{
  services = {
    tlp = {
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

        INTEL_GPU_MIN_FREQ_ON_AC = 500;
        INTEL_GPU_MAX_FREQ_ON_AC = 1100;
        INTEL_GPU_BOOT_FREQ_ON_AC = 1100;

        INTEL_GPU_MIN_FREQ_ON_BAT = 500;
        INTEL_GPU_MAX_FREQ_ON_BAT = 1100;
        INTEL_GPU_BOOST_FREQ_ON_BAT = 1100;
      };
    };

    power-profiles-daemon.enable = false;
  };
}
