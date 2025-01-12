{ config, pkgs, inputs, ... }:

{
    programs.hyprland.enable = true

    environment.systemPackages = with pkgs; [
        kitty
        wofi
        hyprshot
        hyprlock
        waybar
        swaynotificationcenter
        font-awesome
    ];
}
