{ config, lib, pkgs, ... }:

{
  options.xresources.enable = lib.mkEnableOption ''
    Use a custom version of Xresources which uses nix-colors.
  '';
  config = lib.mkIf config.xresources.enable {
    home = {
      packages = with pkgs; [ xorg.xrdb ];

      file.".Xresources".text = with config.colorScheme.palette; ''
        ! Color theme to be placed in ~/.Xresources file
        ! Enable it at runtime with :
        ! $ xrdb ~/.Xresources
        ! or
        ! $ cat ~/.Xresources | xrdb

        *background: #${base00}
        *foreground: #${base07}
        *color0:     #${base00}
        *color1:     #${base01}
        *color2:     #${base02}
        *color3:     #${base03}
        *color4:     #${base04}
        *color5:     #${base05}
        *color6:     #${base06}
        *color7:     #${base07}
        *color8:     #${base08}
        *color9:     #${base09}
        *color10:    #${base0A}
        *color11:    #${base0B}
        *color12:    #${base0C}
        *color13:    #${base0D}
        *color14:    #${base0E}
        *color15:    #${base0F}
      '';
    };
  };
}
