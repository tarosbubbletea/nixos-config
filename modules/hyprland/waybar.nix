{config, lib, user, pkgs, ...}:

{
  my.programs.waybar.enable = true;    
  my.xdg.configFile = {
    "waybar/themes/theme.css".source = ./waybar/themes/Wall-Dcol.css;
  };
}

