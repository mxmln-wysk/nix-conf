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
        pywal16
	pywalfox-native
        blueberry
	pavucontrol
	pulseaudio
        bluez
	wlogout
        swaynotificationcenter
	playerctl
        font-awesome
        nwg-look
	nwg-displays
	jq
	polkit_gnome
        wpgtk
        hyprcursor
        cliphist
        wl-clipboard
    ];
}
