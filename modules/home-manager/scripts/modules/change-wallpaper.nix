{ config, lib, pkgs, ... }:

{
  options = {
    changeWallpaper.enable = lib.mkEnableOption ''
      Enable script to change wallpaper.
    '';
  };

  config = lib.mkIf config.changeWallpaper.enable {
    home.packages = with pkgs;
      [
        (pkgs.writeShellApplication {
          name = "sbg";
          runtimeInputs = with pkgs; [ sxiv hyprpaper dunst ];
          text = ''
            shared_wall_dir=~/.local/share/wallpapers/
            sys_wall=~/.local/share/active-wallpaper.jpg

            wall=$(sxiv -ftor $shared_wall_dir | head -n1)

            [ -z "$wall" ] && notify-send -u low -t 3000 "No Wallpaper Selected" "Aborting..." && exit 1

            # Change wallpaper.
            pkill hyprpaper ; hyprpaper & disown
            hyprctl hyprpaper unload "$sys_wall"
            rm "$sys_wall"
            ln -s "$wall" "$sys_wall"
            hyprctl hyprpaper preload "$sys_wall"
            hyprctl hyprpaper wallpaper ",$sys_wall"

            notify-send -u low -t 3000 "Changed Wallpaper" &
          '';
        })
      ];
  };
}
