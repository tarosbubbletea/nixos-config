{config, lib, user, ...}:

{
  programs.waybar.enable = true;
	xdg.configFile."waybar" = {
		source = ./waybar;
		recursive = true;
	};
	xdg.configFile."waybar/themes/theme.css".source = ./waybar/themes/Wall-Dcol.css;
}

