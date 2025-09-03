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
        cd ~/pictures/wallpapers/ || exit

        while true
        do
            choice=$(find -- * -type d | wofi -i -p "Select wallpaper type:" --dmenu)
            [ ! "$choice" ] && exit 1

            selected_wallpaper=$(sxiv -tor ~/pictures/wallpapers/"$choice" | tail -n 1)
            [ "$selected_wallpaper" != "" ] && break
        done

        pkill swaybg
        swaybg -m fill -i "$selected_wallpaper" &

        ln -sf "$selected_wallpaper" ~/.local/share/current-wallpaper
      '';
    })
  ];
}
