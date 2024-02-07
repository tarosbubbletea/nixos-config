{config, lib, user, ...}:

{
  my.programs.waybar.enable = true;    
  my.xdg.configFile = {
    "waybar" = {
    source = lib.file.mkOutOfStoreSymlink ./waybar;
    recursive = true;
    };
    "waybar/themes/theme.css".source = ./waybar/themes/Wall-Dcol.css;
  };
}

