{config, lib, pkgs, user, ...}:

{
	imports = [
		./waybar.nix
	];

	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};

	environment.sessionVariables = {
		#WLR_NO_HARDWARE_CURSORS = "1";
		#electron support
		NIXOS_OZONE_WL = "1";
	};

	hardware = {
		opengl.enable = true;
		opengl.extraPackages = with pkgs; [
			intel-media-driver
			#vaapiIntel
			vaapiVdpau
			libvdpau-va-gl
		];
	};

	home.file = {
		hyprcfg.source = lib.file.mkOutOfStoreSymlink ./hyprland.conf;
		hyprcfg.target = "/home/${user}/.config/hypr/hyprland.conf";
		"wall.jpg".source = ./1.jpg;
	};
}
