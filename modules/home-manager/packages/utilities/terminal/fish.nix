{ pkgs, userSettings, ... }:

{
  home.packages = with pkgs; [
    fzf
    fd
  ];

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      set fish_user_paths /usr/local/bin /home/${userSettings.user.name}/.local/bin /home/${userSettings.user.name}/.config/emacs/bin
      set fish_vi_key_bindings

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
    };

    functions = {
      fish_user_key_bindings.body = "fzf_key_bindings";
    };
  };
}
