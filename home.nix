{ config, pkgs, ... }:

{
	home.username = "htgar";
  home.homeDirectory = "/home/htgar";

  home.stateVersion = "23.05";

	news.display = "silent";

  home.packages = [
    pkgs.ripgrep
    pkgs.fd
    pkgs.gcc
		pkgs.devbox
  ];

  home.file = {
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Shell
  programs.bash = {
    enable = true;
  };

  programs.readline = {
    enable = true;
    extraConfig = builtins.readFile ./inputrc;
  };

	# Tools

	# Direnv
	programs.direnv = {
		enable = true;
		enableBashIntegration = true;
		nix-direnv.enable = true;
	};

	# Starship
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

	# Bat
	programs.bat = {
		enable = true;
		config = {
			theme = "catppuccin-mocha";
		};
		themes = {
			catppuccin-mocha = {
				src = ./bat/themes;
				file = "Catppuccin-mocha.tmTheme";
			};
		};
  };

  # Neovim
  programs.neovim = {
    enable = true;
		defaultEditor = true;
    extraLuaConfig = builtins.readFile ./nvim/init.lua;
  };

	# Git
	programs.git = {
		enable = true;
		delta = {
			enable = true;
			options = {};
		};
		lfs.enable = true;
		userName = "htgar";
		userEmail = "development@htgar.org";
	};
	programs.git-credential-oauth.enable = true;

	# Tmux
	programs.tmux = {
		enable = true;
		extraConfig = builtins.readFile ./tmux/tmux.conf;
		plugins = with pkgs.tmuxPlugins; [
			vim-tmux-navigator
			catppuccin
		];
	};
}
