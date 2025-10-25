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
      use_search_box = false;

      key_down = "Alt-j,Down";
      key_up = "Alt-k,Up";
      key_left = "Alt-h,Left";
      key_right = "Alt-l,Right";
      key_expand = "Tab";
    };
    style = builtins.readFile ./style.css;
  };
}
