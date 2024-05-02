{ config, pkgs, inputs, ... }:

{
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

	environment.gnome.excludePackages = (with pkgs; [
		gnome-photos
		gnome-tour
		gnome-text-editor
		gnome-connections #remote desktop client
	]) ++ (with pkgs.gnome; [
		cheese # webcam tool
		#gnome-music
		gnome-terminal
		gnome-maps
		gnome-contacts
		gnome-weather
		gnome-calendar
		yelp #gnome helper
		epiphany # web browser
		geary # email reader
		#evince # document viewer
		#gnome-characters
		#totem # video player
		tali # poker game
		iagno # go game
		hitori # sudoku game
		atomix # puzzle game
	]);
    
}