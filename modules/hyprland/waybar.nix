{config, lib, user, ...}:

{
  my.programs.waybar.enable = true;    
  my.xdg.configFile = {
    "waybar" = {
    source = ./waybar;
    recursive = true;
    };
    "waybar/themes/theme.css".source = ./waybar/themes/Wall-Dcol.css;
  };
}

