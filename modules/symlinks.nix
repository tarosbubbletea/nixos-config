{user, lib, inputs, ...}:

{
  #doesnt seem to truly symlink things in a flake. sooo time for weird hacks i guess
  home-manager.users.${user} = { config, pkgs, ... }: {
    lib.meta = {
      configPath = "/etc/nixos/";
      mkMutableSymlink = path: config.lib.file.mkOutOfStoreSymlink
        (config.lib.meta.configPath + lib.strings.removePrefix (toString inputs.self) (toString path));
    };
    home.file = {
      ".config/nvim/coc-settings.json".source = config.lib.meta.mkMutableSymlink ./nvim/coc-settings.json;
      ".config/init.sh".source = config.lib.meta.mkMutableSymlink ./hyprland/init.sh;
      ".config/waybar".source = config.lib.meta.mkMutableSymlink ./hyprland/waybar;
      ".config/hypr".source = config.lib.meta.mkMutableSymlink ./hyprland/hypr;
      ".config/kitty/kitty.conf".source = config.lib.meta.mkMutableSymlink ./hyprland/kitty.conf;
    };

  };
}