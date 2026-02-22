{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fzf
    fd
  ];

  programs.fish = {
    enable = true;
    generateCompletions = false;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      set fish_user_paths ~/.config/emacs/bin
      set fish_vi_key_bindings

      fzf --fish | source

      if test (tty) = "/dev/tty1"
         exec niri-session
      end
    '';

    shellAliases = {
      bc = "${pkgs.bc}/bin/bc -l";
      mkdir = "mkdir -pv";
      ports = "netstat -tulanp";

      root = "sudo -i";

      df = "df -H";
      du = "du -ch";
    };
  };
}
