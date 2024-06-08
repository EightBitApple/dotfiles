{
  config,
  lib,
  pkgs,
  ...
}:

{

  options.dunst.enable = lib.mkEnableOption ''
    Install and configure Dunst notifcations.
  '';

  config = lib.mkIf config.dunst.enable {
    services.dunst = {
      enable = true;
      settings = {
        global = {
          follow = "keyboard";
          width = "(300 1000)";
          height = 950;
          origin = "top-right";
          offset = "48x60";
          scale = 0;
          notification_limit = 10;
          progress_bar = true;
          progress_bar_height = 10;
          progress_bar_frame_width = 1;
          progress_bar_min_width = 150;
          progress_bar_max_width = 300;
          indicate_hidden = "yes";
          separator_height = 2;
          padding = 10;
          text_icon_padding = 0;
          frame_width = 3;
          gap_size = 0;
          separator_color = "frame";
          sort = "yes";
          font = "FiraCode Nerd Font 12";
          idle_threshold = 120;
          line_height = 10;
          markup = "full";
          format = ''
            <b>%s</b>
            %b
          '';
          alignment = "left";
          vertical_alignment = "top";
          show_age_threshold = 60;
          word_wrap = "yes";
          ellipsize = "end";
          ignore_newline = "no";
          stack_duplicates = true;
          hide_duplicate_count = false;
          show_indicators = "yes";
          enable_recursive_icon_lookup = true;
          sticky_history = "yes";
          history_length = 50;
          browser = "firefox";
          always_run_script = true;
          title = "Dunst";
          class = "Dunst";
          corner_radius = 2;
          progress_bar_corner_radius = 2;
          ignore_dbusclose = false;
          force_xwayland = false;
          force_xinerama = false;
          mouse_left_click = "close_current";
          mouse_middle_click = "do_action, close_current";
          mouse_right_click = "close_all";
        };

        # These are the keybindings used to control dunst notifications
        shortcuts = {
          close = "ctrl+space";
          close_all = "ctrl+shift+space";
          history = "ctrl+grave";
        };

        # Set the background and foreground (text) color for all notifications
        urgency_low = with config.colorScheme.palette; {
          background = "#${base01}BF";
          foreground = "#${base07}BF";
          highlight = "#${base0C}BF";
          msg_urgency = "low";
        };

        urgency_normal = with config.colorScheme.palette; {
          background = "#${base01}BF";
          foreground = "#${base07}BF";
          highlight = "#${base0C}BF";
          msg_urgency = "normal";
          script = "~/.nix-profile/bin/notif-sound";
        };

        urgency_critical = with config.colorScheme.palette; {
          background = "#${base08}BF";
          foreground = "#${base07}BF";
          highlight = "#${base09}BF";
          msg_urgency = "critical";
          script = "~/.nix-profile/bin/notif-sound";
        };
      };
    };
    home.packages = with pkgs; [ libnotify ];
  };
}
