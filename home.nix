{ user, config, pkgs, inputs, filesIn, ... }:

{
  imports = [ 
    ./modules/fish/fish.nix
    ./modules/nvim/nvim.nix
		./modules/hyprland/hyprland.nix
  ];

  home.username = "taro";
  home.homeDirectory = "/home/taro";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
		nixd
		bun
		nodejs

		waybar
		(pkgs.waybar.overrideAttrs (oldAttrs: {
			mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
			})
		)

		dunst
		libnotify
		rofi-wayland
		networkmanagerapplet
		kitty


    (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # ''
    (pkgs.writeShellScriptBin "nix-apply" ''sudo nixos-rebuild switch --flake /etc/nixos/#default $1'')
    (pkgs.writeShellScriptBin "nix-gens" ''sudo nix-env --list-generations --profile /nix/var/nix/profiles/system'')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/taro/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    
  };

  #raw files
  home.file."/home/${user}/.ssh/authorized_keys".source = ./ssh.pub;

  #fix that flake command-not-found problem
  programs.nix-index =
  {
    enable = true;
    enableFishIntegration = true;
  };
  programs.home-manager.enable = true;
}
