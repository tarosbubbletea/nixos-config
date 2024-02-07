{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixos-boot.url = "github:Melkor333/nixos-boot";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {

				specialArgs = {
					inherit inputs;
					user = "taro";
				};
				
				modules = [ 
 						./configuration.nix
						inputs.home-manager.nixosModules.default
						inputs.nixos-boot.nixosModules.default
				];
			};

    };
}
