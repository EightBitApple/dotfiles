{ userSettings, ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      normal_window = true;
      show = "drun";
      term = "${userSettings.terminal.name}";
      show_all = true;
      gtk_dark = false;
      location = "center";
      insensitive = false;
      allow_markup = true;
      allow_images = true;
      line_wrap = "word";
      lines = 8;
      width = "30%";
      hide_scroll = true;
    };
    style = builtins.readFile ./style.css;
  };
}
