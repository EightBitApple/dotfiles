{ pkgs, ... }:

{
  programs = {
    steam = {
      enable = true;
      extest.enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
      protontricks.enable = true;
    };

    gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general.renice = 10;
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
}
