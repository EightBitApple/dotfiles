<<<<<<< ours
<<<<<<< Updated upstream
{ config, lib, pkgs, ... }:
=======
{ config, lib, pkgs, userSettings, ... }:
>>>>>>> Stashed changes
=======
{ config, lib, pkgs, userSettings, ... }:
>>>>>>> theirs

{
  options.emacsclientStarter.enable = lib.mkEnableOption ''
    Enable script to start emacs client and server.
  '';
  config = lib.mkIf config.emacsclientStarter.enable {

    home.packages = with pkgs;
      [
        (pkgs.writeShellApplication {
          name = "emc";
<<<<<<< ours
<<<<<<< Updated upstream
          runtimeInputs = with pkgs; [ dunst emacs29-pgtk ];
          text = ''
            # A simple script to notify the user that an Emacs server is starting, and that
            # the frame they just opened is a client.
            # The user can also pass file paths to this script for emacsclient to open.


            startEmacsServer() {
            	notify 3000 "No server running. Starting a server now."
            	export LSP_USE_PLISTS=true && emacs --daemon
=======
=======
>>>>>>> theirs
          runtimeInputs = with pkgs; [ dunst userSettings.emacsPkg ];
          text = ''
            # A simple script to notify the user that an Emacs server is
            # starting, and that the frame they just opened is a client. The
            # user can also pass file paths to this script for emacsclient to
            # open.

            startEmacsServer() {
            	notify 3000 "No server running. Starting a server now."
            	systemctl --user start emacs.service
<<<<<<< ours
>>>>>>> Stashed changes
=======
>>>>>>> theirs
            	notify 3000 "Server started running."
            }

            restartEmacsServer() {
            	notify 3000 "Restarting running server."
<<<<<<< ours
<<<<<<< Updated upstream
            	emacsclient -e '(kill-emacs)'
            	startEmacsServer;
=======
            	systemctl --user restart emacs.service
>>>>>>> Stashed changes
=======
            	systemctl --user restart emacs.service
>>>>>>> theirs
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
