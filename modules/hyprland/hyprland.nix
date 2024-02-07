{config, lib, pkgs, user, environment, ...}:

{
	imports = [
		./waybar.nix
	];

	home.packages = with pkgs; [
		#waybar
		#(pkgs.waybar.overrideAttrs (oldAttrs: {
		#	mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
		#	})
		#)

		swww
		dunst
		libnotify
		rofi-wayland
		networkmanagerapplet
		kitty
	];

	wayland.windowManager.hyprland = {
  	enable = true;
    #nvidiaPatches = true;
		systemd.enable = true;
	};


	
		home.file.".config/hyprland/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/modules/hyprland/hyprland.conf;
		home.file."wall.jpg".source = ./1.jpg;
	
}
