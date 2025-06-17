{ pkgs, userSettings, ... }:

let
  cmd_mpv = "mpv --no-video --shuffle --loop-playlist";
  ytUrl = "https://youtube.com/playlist?list=PL_tDOyt4AsK";
in
{
  home.packages = with pkgs; [
    fzf
    fd
    starship
  ];

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      set fish_user_paths /usr/local/bin /home/${userSettings.user.name}/.local/bin /home/${userSettings.user.name}/.config/emacs/bin
      set fish_vi_key_bindings
      starship init fish | source

      if test (tty) = "/dev/tty1"
         exec Hyprland
      end
    '';

    shellAliases = {
      bc = "${pkgs.bc}/bin/bc -l";
      mkdir = "mkdir -pv";
      ping = "ping -c 5";
      ports = "netstat -tulanp";

      # safety nets
      mv = "mv -i";
      cp = "cp -i";
      ln = "ln -i";

      root = "sudo -i";

      df = "df -H";
      du = "du -ch";

      # music
      mus_tracker = "${cmd_mpv} '${ytUrl}c-PxwyDgbpZXWBLGQwDa9u'";
      mus_tracker_chill = "${cmd_mpv} '${ytUrl}eakyEJjSWTrQIH12h512Iw'";
      mus_tracker_chip = "${cmd_mpv} '${ytUrl}eyv5d9zFysHFoMR3PeKAo_'";
      mus_tracker_vg = "${cmd_mpv} '${ytUrl}e645jBv86ivf9w7UjwJ2KE'";
    };

    functions = {
      fish_user_key_bindings.body = "fzf_key_bindings";
    };
  };
}
