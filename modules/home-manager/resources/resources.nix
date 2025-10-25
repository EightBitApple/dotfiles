{
  home.file = {
    ".local/share/soundfonts".source = ./soundfonts;
    ".local/share/wallpapers".source = ./wallpapers;
    ".local/share/system-sounds".source = ./system-sounds;
    ".local/share/styling".source = ./styling;
  };

  xresources.extraConfig = ''
    Sxiv.background: #161616
    Sxiv.foreground: #FFFFFF
    Sxiv.font: Hack-12
  '';
}
