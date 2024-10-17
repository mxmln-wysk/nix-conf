{ config, pkgs, inputs,stylix, home-manager,... }:

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

  services.xserver.enable = true; # Enable the X11 windowing system.
 
  services.printing.enable = true; # Enable CUPS to print documents
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  users.users.mwysk = {
    isNormalUser = true;
    description = "Maximilian Wysk";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    ];
  };
	
	home-manager = {
		extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
		users = {
			"mwysk" = import ./home.nix;
		};
    sharedModules = [{
      stylix.targets.gnome.enable = false;
    }];
	};
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.enableParallelBuildingByDefault = false;

  programs.appimage.binfmt = true;#?

  environment.systemPackages = with pkgs; [
    gedit
    thunderbird
    fastfetch
    google-chrome
    dropbox
    keepassxc
    htop
    qogir-theme
    qogir-icon-theme
    #gnome.dconf-editor
    vlc
    zoom-us
    spotify
    gparted
    converseen #imageConverter
    libreoffice-still
    logseq
    zotero
    audible-cli
    gimp
    inkscape
    pitivi#video editor
    errands#todo app
    ventoy#live usb maker
    yt-dlp#youtube Downloader
    meld#Visual diff and merge tool
    ntfs3g #ntfsfix
    feh#image slide show
    brave
    pika-backup
    gencfsm #encrytping
    ffmpeg
    audible-cli
    #programming
    git
    php
    nodejs_20
    virt-manager
    python3
    chromedriver
    vscode
    filezilla
    rpi-imager
  ];

nixpkgs.overlays = [
  (
    final: prev: {
      logseq = prev.logseq.override {
        electron = prev.electron_27;
      };
    }
  )
];

  nixpkgs.config.allowBroken = true;
  nixpkgs.config.permittedInsecurePackages = [
   "electron-28.3.3"#look if this is necessary for next update
   "electron-27.3.11"#look if this is necessary for next update
  ];
  

  services.mysql = {
    enable = false;
    package = pkgs.mariadb;
};
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [(pkgs.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd];
      };
    };
  };
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    noto-fonts-emoji
    noto-fonts
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
