{ config, pkgs, inputs, ... }:

{
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

	stylix = {
        image = /home/mwysk/nix-conf/wallpaper.png;
        base16Scheme = {
            base00 = "0e3c46";
            base01 = "1d494e";
            base02 = "2A5054";
            base03 = "587073";
            base04 = "9DC8CD";
            base05 = "F0F8FF"; #alice blue
            base06 = "CBF2F7";
            base07 = "F0F8FF"; #alice blue
            base08 = "fb6953";
            base09 = "fcab74";
            base0A = "fce380";
            base0B = "73d8ad";
            base0C = "3fb2b9";
            base0D = "FF7F50"; #coral
            base0E = "756b8a";
            base0F = "FF7F50"; #coral
        };    
        #base16Scheme = "${pkgs.base16-schemes}/share/themes/silk-dark.yaml";
        cursor = { 
            package = pkgs.qogir-theme;
            name = "Qogir";
        };
        fonts = { 
        serif = {
            package = pkgs.roboto;
            name = "Roboto Medium";
        };
        sansSerif = {
            package = pkgs.roboto;
            name = "Roboto Medium";
        };
        monospace = {
            package = pkgs.roboto-mono;
            name = "Roboto Mono Medium";
        };
        emoji = {
            package = pkgs.noto-fonts-emoji;
            name = "Noto Color Emoji";
        };
        };
    };

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


	environment.systemPackages = with pkgs;[
		gnomeExtensions.alphabetical-app-grid
		gnomeExtensions.bluetooth-quick-connect
		gnomeExtensions.color-picker
		gnomeExtensions.date-menu-formatter
		gnomeExtensions.extension-list
		gnomeExtensions.forge
		gnomeExtensions.grand-theft-focus
		gnomeExtensions.user-themes
		gnomeExtensions.vitals
	];
}
