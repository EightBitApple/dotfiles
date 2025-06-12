{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "change-wallpaper";
      runtimeInputs = [
        libnotify
        sxiv
      ];
      text = ''
        selected_wallpaper=$(sxiv -tor ~/pictures/wallpapers | tail -n 1)

        if [ "$selected_wallpaper" = "" ]; then
            notify-send -t 3000 "Change Wallpaper" "No wallpaper selected, exiting..."
            exit 1;
        fi

        pkill swaybg
        swaybg -m fill -i "$selected_wallpaper" &
        ln -sf "$selected_wallpaper" ~/.local/share/current-wallpaper
      '';
    })
  ];
}
