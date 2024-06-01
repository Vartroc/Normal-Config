{
	description = "Nixos config flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		disko = {
			url = "github:nix-community/disko";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		impermanence.url = "github:nix-community/impermanence";
	};

  	outputs = { self, nixpkgs, ... }@inputs: {
    		nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      			specialArgs = {inherit inputs;};
      			modules = [
        			./modules/configuration.nix
        		# 	inputs.home-manager.nixosModules.default
				inputs.impermanence.nixosModules.impermanence
				inputs.disko.nixosModules.default

      			];
    		};
  	};
}
