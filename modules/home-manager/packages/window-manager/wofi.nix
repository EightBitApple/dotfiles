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
    style =
      let
        readStyle = file: builtins.readFile ../../resources/stylings/${file}.css;
      in
      ''
        ${readStyle "text"}

        * {
          font-family: DejaVu Sans;
          color: @text_color_white;
        }

        #input, #entry, #window {
          padding: 10px;
          margin: 8px;

          ${readStyle "button"}
          ${readStyle "highlights"}
        }

        #window {
          border-radius: 0px;
          padding: 12px;

          ${readStyle "aero-glass"}
        }

        #entry {
          padding: 4px;
          margin: 4px;
          margin-left: 16px;
          margin-right: 16px;
        }

        #entry:selected, #expander-box {
          outline: none;
          animation: expand 0.2s ease-out;
          margin-left: 5px;
          margin-right: 5px;

          ${readStyle "select"}
        }

        #expander-box { background: none; }
        #img { margin-right: 15px; }

        #text { color: @text_color_white; }
        #text:selected { color: @text_color; }

        ${readStyle "animation/expand"}
      '';
  };
}
