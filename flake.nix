{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    stylix = {
    url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };    
    };
      home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self,stylix, nixpkgs, home-manager, ... }:
  	let 
  		lib = nixpkgs.lib;
   in {
    nixosConfigurations.nixPadT480 = lib.nixosSystem {
			system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./gnome/default.nix
          {
            nix.settings = {
            };
          }
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mwysk = import ./home.nix;
          }
      ];
    };
  };
}
