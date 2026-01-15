{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  outputs = inputs@{ self, nixpkgs, ... }:
  	let 
  		lib = nixpkgs.lib;
   in {
    nixosConfigurations.nixPadT480 = lib.nixosSystem {
			system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./gnome/default.nix
        ./hyprland/default.nix
          {
            nix.settings = {
            };
          }
      ];
    };
  };
}
