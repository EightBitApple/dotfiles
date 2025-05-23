{ pkgs, userSettings, ... }:

{
  home.packages = with pkgs; [
    fzf
    fd
  ];

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      ignoreAllDups = true;
      path = "$HOME/.zsh_history";

      ignorePatterns = [
        "rm *"
        "pkill *"
        "cp *"
      ];
    };

    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      c = "clear";
      bc = "${pkgs.bc}/bin/bc -l";
      mkdir = "mkdir -pv";
      diff = "${pkgs.colordiff}/bin/colordiff";
      ping = "ping -c 5";
      ports = "netstat -tulanp";

      # safety nets
      mv = "mv -i";
      cp = "cp -i";
      ln = "ln -i";

      # become root
      root = "sudo -i";

      df = "df -H";
      du = "du -ch";
    };

    envExtra = ''
      path=('/usr/local/bin' $path)
      path+=('/home/${userSettings.user.name}/.local/bin')
      path+=('/home/${userSettings.user.name}/.config/emacs/bin')
      export PATH

      export FZF_CTRL_T_COMMAND="fd --full-path"
      export FZF_ALT_C_COMMAND="fd -t d"
    '';

    initContent = ''
      PROMPT="%B%~%b
      ❯ "

      if [ -n "$commands [ fzf-share ]" ]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
      fi

      # vi mode
      bindkey -v
      export KEYTIMEOUT=1

      # Change cursor shape for different vi modes.
      function zle-keymap-select {
        if [[ $KEYMAP == vicmd ]] ||
          [[ $1 = 'block' ]]; then
          echo -ne '\e[1 q'
        elif [[ $KEYMAP == main ]] ||
            [[ $KEYMAP == viins ]] ||
            [[ $KEYMAP =  "" ]] ||
            [[ $1 = 'beam' ]]; then
          echo -ne '\e[5 q'
        fi
      }
      zle -N zle-keymap-select
      zle-line-init() {
          zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
          echo -ne "\e[5 q"
      }
      zle -N zle-line-init
      echo -ne '\e[5 q' # Use beam shape cursor on startup.
      preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

      [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ] && exec Hyprland
    '';
  };
}
