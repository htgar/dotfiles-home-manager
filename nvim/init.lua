-- Inspired from https://gitlab.com/domsch1988/mvim, https://github.com/nvim-lua/kickstart.nvim, https://github.com/vimjoyer/nvim-nix-video
-- Configured using home-manager, this init.lua is mainly in case I have to use this config on non-nix systems

require('lazy')
require('options')
require('keymaps')
require('autocommands')
require('treesitter')
require('lsp')
