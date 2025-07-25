{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      gimp3
      imagemagick
    ];

    file.".config/swappy/config".text = ''
      [Default]
      save_dir=$HOME/pictures/screenshots
      save_filename_format=swappy-%Y%m%d-%H%M%S.png
      show_panel=false
      line_size=5
      text_size=20
      text_font=sans-serif
      paint_mode=brush
      early_exit=false
      fill_shape=false
    '';
  };
}
