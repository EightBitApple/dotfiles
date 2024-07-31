{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:

{
  options.textEditors.enable = lib.mkEnableOption ''
    Install text editors.
  '';

  config = lib.mkIf config.textEditors.enable {
    programs = {
      emacs = {
        enable = true;
        package = userSettings.emacsPkg;
        extraPackages = epkgs: [ epkgs.vterm ];
      };
      neovim.enable = true;
    };

    home.packages = with pkgs; [
      python3
      ripgrep
      gnumake

      (writeShellApplication {
        name = "emc";
        runtimeInputs = [ dunst ];
        text = ''
          # A simple script to notify the user that an Emacs server is starting, and that
          # the frame they just opened is a client.
          # The user can also pass file paths to this script for emacsclient to open.

          startEmacsServer() {
            notify 3000 "No server running. Starting a server now."
            systemctl --user start emacs.service
            notify 3000 "Server started running."
          }

          restartEmacsServer() {
            notify 3000 "Restarting running server."
            emacsclient -e '(kill-emacs)'
            startEmacsServer;
            systemctl --user restart emacs.service
            startClient;
          }

          startClient() {
            notify 1000 "Starting the client."
            emacsclient -c &
          }

          notify() {
            duration="$1"
            title="Emacs Client"
            message="$2"

            notify-send -u low -t "$duration" "$title" "$message" &
          }

          for arg in "$@"; do
            if [ "$arg" = "-r" ]; then
              restartEmacsServer
              exit 0;
            fi
          done

          startClient
        '';
      })
    ];
  };
}
