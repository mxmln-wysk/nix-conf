{ config, pkgs, inputs, ... }:

{
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;


    environment.systemPackages = with pkgs; [
      gnome-tweaks
      gnomeExtensions.alphabetical-app-grid
			gnomeExtensions.bluetooth-quick-connect
			gnomeExtensions.color-picker
			gnomeExtensions.date-menu-formatter
			gnomeExtensions.extension-list
			gnomeExtensions.forge
			gnomeExtensions.grand-theft-focus
			gnomeExtensions.user-themes
			gnomeExtensions.vitals
			gnome-boxes
    ];
	environment.gnome.excludePackages = (with pkgs; [
		gnome-photos
		gnome-tour
		gnome-text-editor
		gnome-connections #remote desktop client
    cheese # webcam tool
    gnome-terminal
		gnome-calendar
		yelp #gnome helper
		epiphany # web browser
		geary # email reader
    gnome-maps
    gnome-contacts
		gnome-weather
		iagno # go game
    tali # poker game
		hitori # sudoku game
		atomix # puzzle game
		#evince # document viewer
		gnome-characters
		#totem # video player

	]) ++ (with pkgs.gnome; [
		#gnome-music
	]);
}
