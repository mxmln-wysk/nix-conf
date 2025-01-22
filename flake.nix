{
  description = "Nixos config flake";

  inputs = {
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
	    nixpkgs.overlays = [inputs.hyprpanel.overlay];
          }
      ];
    };
  };
}
