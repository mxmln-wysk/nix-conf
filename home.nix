{ config, pkgs, ... }:

{
  home.username = "mwysk";
  home.homeDirectory = "/home/mwysk";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    #pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
  #home.sessionVariables.GTK_THEME = "Qogir";

  #home.sessionVariables.GTK_THEME = "qogir";	
  programs = {
		git = {
		  enable = true;
		  userName  = "mxmln-wysk";
		  userEmail = "maximilian.wysk@gmx.net";
		};
		bash = {
			enable = true;
			shellAliases = {
				".." = "cd ..";
				"cdn" = "cd /etc/nixos/";
        "update" = "sudo nix flake update";
        "switch" = "sudo nixos-rebuild switch --flake .";
        "remove" = "sudo nix-collect-garbage -d";
			};
			initExtra =''
				source ~/.bashScripts/git-prompt.sh
				export PS1='[$(tput bold)\[$(tput setaf 214)\]\u\[$(tput setaf 112)\]@\h\[$(tput setaf 75)\] \W\[$(tput setaf 220)\]\[$(__git_ps1 " {%s}")\]\[$(tput sgr0)\]] => '
				'';
		};
  };
  #@toDo auslagern in gnome/default.nix
  #dconf.settings = {
  #      "org/gnome/desktop/background" = {
  #      picture-uri = "file:///etc/nixos/wallpaper.webp";
   #     };
  #  };


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/mwysk/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
