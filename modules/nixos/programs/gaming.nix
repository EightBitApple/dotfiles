{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:

{
  options.gaming.enable = lib.mkEnableOption ''
    Enable and configure programs for gaming.
  '';

  config = lib.mkIf config.gaming.enable {
    programs = {
      steam = {
        enable = true;
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
        gamescopeSession = {
          enable = true;
          args = [
            "-r 75"
            "--adaptive-sync"
          ];
        };
      };

      gamemode = {
        enable = true;
        enableRenice = true;
        settings = {
          # Warning: GPU optimisations have the potential to damage hardware
          gpu = {
            gpu_device = 0;
            amd_performance_level = "high";
          };
          custom = {
            start = "${pkgs.libnotify}/bin/notify-send -t 3000 'GameMode started.'";
            end = "${pkgs.libnotify}/bin/notify-send -t 3000 'GameMode ended.'";
          };
        };
      };

      gamescope = {
        enable = true;
        capSysNice = true;
      };
    };
  };
}
