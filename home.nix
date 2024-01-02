{ config, pkgs, ... }:

{
  home.username = "htgar";
  home.homeDirectory = "/home/htgar";
  home.stateVersion = "23.05";

  news.display = "silent";

  home.packages = [
    pkgs.ripgrep
    pkgs.fd
    pkgs.wl-clipboard
    pkgs.gcc     

    # Main LSPs
    pkgs.rnix-lsp
    pkgs.lua-language-server

  ];

# Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

# Shell
  programs.bash = {
    enable = true;
    sessionVariables = {
      EDITOR = "nvim";
      MANPAGER = "nvim";
    };
    initExtra = ''
      source <(gh completion -s bash)	
      '';
  };

  programs.readline = {
    enable = true;
    extraConfig = builtins.readFile ./inputrc;
  };

# Neovim
  programs.neovim =
  {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
    ];

    extraLuaConfig = builtins.readFile ./nvim/init.lua;

  };

# Git
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "htgar";
    userEmail = "development@htgar.org";
  };

  programs.gh = {
    enable = true;
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
}
