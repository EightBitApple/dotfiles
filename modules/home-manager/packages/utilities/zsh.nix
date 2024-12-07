{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:

{
  options.zsh.enable = lib.mkEnableOption ''
    Install configure zsh.
  '';

  config = lib.mkIf config.zsh.enable {
    home.packages = with pkgs; [
      fzf
      fd
    ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
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
      envExtra = ''
        path=('/usr/local/bin' $path)
        path+=('/home/${userSettings.username}/.local/bin')
        path+=('/home/${userSettings.username}/.config/emacs/bin')
        export PATH

        export FZF_CTRL_T_COMMAND="fd --full-path"
        export FZF_ALT_C_COMMAND="fd -t d"
      '';

      initExtra = ''
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
      '';
    };
  };
}
