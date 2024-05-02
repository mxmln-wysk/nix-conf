{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
  	let 
  		lib = nixpkgs.lib;
   in {
    nixosConfigurations.nixPadT440s = lib.nixosSystem {
			system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./gnome/default.nix
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
