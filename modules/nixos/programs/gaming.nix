{ pkgs, ... }:

{
  programs = {
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
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
  };
}
