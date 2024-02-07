{ config, pkgs, inputs, user, ...}:

{
  programs.fish.enable = true;
  users.users.${user}.shell = pkgs.fish;
  my.programs.fish = {
    enable = true;  
    shellInit = builtins.readFile ./config.fish;
    
    plugins = [
      {
        name = "sudope";
	      src = pkgs.fetchFromGitHub {
	        owner = "oh-my-fish";
	        repo = "plugin-sudope";
          rev = "83919a692bc1194aa322f3627c859fecace5f496";
	        sha256 = "pD4rNuqg6TG22L9m8425CO2iqcYm8JaAEXIVa0H/v/U=";
	      };
      }
    ];
  };


  #it's like magic
  my.home.file.".config/fish/conf.d/nix-env.fish".source = ./setup-with-nix.fish;
}
