{...}:

{
  home-manager.users.${user} = { config, pkgs, ... }: {
    home.file = {
      ".config/nvim/coc-settings.json".source = config.lib.file.mkOutOfStoreSymlink ./nvim/coc-settings.json;
      ".config/init.sh".source = config.lib.file.mkOutOfStoreSymlink ./hyprland/init.sh;
      
    };
}