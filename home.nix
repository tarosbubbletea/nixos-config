{ user, config, pkgs, inputs, filesIn, lib, ... }:

{
  imports = [ 
    (lib.mkAliasOptionModule ["my"] ["home-manager" "users" "${user}"])
    ./modules/symlinks.nix
    ./modules/fish/fish.nix
    ./modules/nvim/nvim.nix
    ./modules/hyprland/hyprland.nix
    ./modules/greeter.nix
  ];

  my.home.username = "${user}";
  my.home.homeDirectory = "/home/${user}";
  my.home.stateVersion = "23.11"; # Please read the comment before changing.

  #fix that flake command-not-found problem
  my.programs = {
    nix-index =
    {
      enable = true;
      enableFishIntegration = true;
    };
    home-manager.enable = true;
  };

  my.home.packages = with pkgs; [
		nixd
		bun
		btop

    (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home-manager.username}!"
    # ''
    (pkgs.writeShellScriptBin "nix-apply" ''sudo nixos-rebuild switch --flake /etc/nixos/#default $@'')
    (pkgs.writeShellScriptBin "nix-gens" ''sudo nix-env --list-generations --profile /nix/var/nix/profiles/system $@'')
    (pkgs.writeShellScriptBin "nix-gens-del" ''sudo nix-env --delete-generations $@'')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home-manager.file'.
  my.home.file = {
    "/home/${user}/.ssh/authorized_keys".source = ./ssh.pub;
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
  # 'home-manager.sessionVariables'. If you don't want to manage your shell through Home
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
  my.home.sessionVariables = {
    EDITOR = "nvim";
  };
}
