{ config, pkgs, ... }:

{
  home.username = "htgar";
  home.homeDirectory = "/home/htgar";
  home.stateVersion = "23.05";

  news.display = "silent";

  home.packages = [
    pkgs.ripgrep
    pkgs.fd
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
        lua-language-server
        rnix-lsp
        gcc # For treesitter
        wl-clipboard
      ];


      extraLuaConfig = ''
        		${builtins.readFile ./nvim/lazy.lua}
        		${builtins.readFile ./nvim/options.lua}
        		${builtins.readFile ./nvim/keymaps.lua}
        		${builtins.readFile ./nvim/autocommands.lua}
        		${builtins.readFile ./nvim/treesitter.lua}
        		${builtins.readFile ./nvim/lsp.lua}
        	'';
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

  programs.gh-dash = {
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
