{ config, pkgs, lib, ...}:

{
  programs.neovim = {
    enable = true;
    plugins = (with pkgs.vimPlugins;
     [
			 ale
			 coc-nvim
			 comment-nvim
       vim-lastplace
       rainbow
       undotree
       vim-airline
       #nvchad
       #nvchad-ui
       #gruvbox
     ]);
    extraConfig = lib.fileContents ./init.vim;
    viAlias = true;
  };
	home.file.".config/nvim/coc-settings.json".source = ./coc-settings.json;
}
