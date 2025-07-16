{ config, pkgs, inputs, ... }:

{
    programs.hyprland.enable = true;

    environment.systemPackages = with pkgs; [
        kitty
	rofi
        hyprshot
        hyprlock
        hyprpaper
        brightnessctl
        waybar
	pywal
	wpgtk
	pywalfox-native
        blueberry
	pavucontrol
	pulseaudio
        bluez
	wlogout
        swaynotificationcenter
	playerctl
	networkmanagerapplet
        font-awesome
        nwg-look
	nwg-displays
	jq
	polkit_gnome
    ];
}
