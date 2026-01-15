{ config, pkgs, inputs,stylix,... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixPadT480"; # Define your hostname.
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "de_DE.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };
  console.keyMap = "de";

  services.xserver.enable = false; # Enable the X11 windowing system.
 
  services.printing.enable = true; # Enable CUPS to print documents
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.flatpak.enable = true;


  users.users.mwysk = {
    isNormalUser = true;
    description = "Maximilian Wysk";
    extraGroups = [ "networkmanager" "wheel" "kvm" ];
    packages = with pkgs; [
      firefox
    ];
  };

  #virtualisation.virtualbox.host.enable = true;
  #users.extraGroups.vboxusers.members = [ "mwysk" ];
  #virtualisation.virtualbox.host.enableExtensionPack = true;
  #virtualisation.virtualbox.guest.enable = true;
  #virtualisation.virtualbox.guest.dragAndDrop = true;
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.enableParallelBuildingByDefault = false;

  environment.systemPackages = with pkgs; [
    gedit
    thunderbird
    fastfetch
    dropbox
    keepassxc
    htop
    qogir-theme
    qogir-icon-theme
    vlc
    zoom-us
    spotify
    gparted
    libreoffice-still
    onlyoffice-desktopeditors
    #obsidian
    logseq
    drawio
    zotero
    gimp3
    inkscape
    pitivi#video editor
    errands#todo app
    yt-dlp#youtube Downloader
    #meld#Visual diff and merge tool
    ntfs3g #ntfsfix
    converseen
    feh#image slide show
    brave
    pika-backup
    #gencfsm #encrytping
    wayfarer#screenrec
    ffmpeg
    imagemagick
    prismlauncher
    pspp
    gnucash #buchfuerung
    perl540Packages.FinanceQuote#for GnuCash
    libation#audible manager
    audio-recorder
    #programming
    gh #github tool
    bc #calculating
    stow
    neovim
    wget
    exfat
    glibc
    electron
    git
    php
    nodejs_20
    python3
    vscode
    filezilla
    rpi-imager
    libxcb-cursor
    openjdk8-bootstrap
    android-tools
    android-studio
  ];


  nixpkgs.config.allowBroken = true;
  nixpkgs.config.permittedInsecurePackages = [
   "electron-28.3.3"#look if this is necessary for next update
   "electron-27.3.11"#look if this is necessary for next update
  ];
  
networking.hosts = {
  "127.0.0.1" = [
    #"www.youtube.com"
    #"youtube.com"
    #"m.youtube.com"
    "lichess.org"
    "www.lichess.org"
    "www.twitch.tv"
    "twitch.tv"
    "de.crazygames.com"
    "www.jetpunk.com"
  ];
};
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
};
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    noto-fonts-color-emoji
    #noto-fonts
    roboto
    roboto-mono
    roboto-slab
    roboto-serif
    dejavu_fonts
  ];

	#Nix flakes
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #nix beta cache should help for faster upgrades
  nix.settings.substituters = [ "https://aseipp-nix-cache.global.ssl.fastly.net" ];

  # This value determines the NixOS release from which the default
  system.stateVersion = "23.11"; # Did you read the comment?
  #automatic Garbage collection. to see it: systemctl list-timers
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
    };
}
