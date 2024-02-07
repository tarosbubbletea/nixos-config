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
    #   ".config/init.sh".source = config.lib.meta.mkMutableSymlink ./hyprland/init.sh;
    #   more than half the settings are stolen (not gonna read the whole bible they have in their site)
      ".config/waybar".source = config.lib.meta.mkMutableSymlink ./hyprland/waybar;
      ".config/hypr".source = config.lib.meta.mkMutableSymlink ./hyprland/hypr; 
      ".config/kitty/kitty.conf".source = config.lib.meta.mkMutableSymlink ./hyprland/kitty.conf;


      ".config/waynergy/config.ini".source = config.lib.meta.mkMutableSymlink ./way.ini;
      ".config/waynergy/xkb_keymap".source = config.lib.meta.mkMutableSymlink ./way_xkb;
      ".config/xkb/keycodes/win".source = config.lib.meta.mkMutableSymlink ./way_key;
    };

  };
}