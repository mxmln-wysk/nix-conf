{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #cosmic DE for testing
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:bluskript/stylix";
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

  outputs = inputs@{ self,stylix, nixpkgs, home-manager,nixos-cosmic, ... }:
  	let 
  		lib = nixpkgs.lib;
   in {
    nixosConfigurations.nixPadT440s = lib.nixosSystem {
			system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./gnome/default.nix
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }
        nixos-cosmic.nixosModules.default
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
