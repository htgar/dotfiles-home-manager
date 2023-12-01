-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default (Covered by Mini Basic)
-- vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode (Covered by Mini Basic)
-- vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- Enable break indent (Covered by Mini Basic)
-- vim.o.breakindent = true

-- Save undo history (Covered by Mini Basic)
-- vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search (Covered by Mini Basic)
-- vim.o.ignorecase = true
-- vim.o.smartcase = true

-- Keep signcolumn on by default (Covered by Mini Basic)
-- vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this (Covered by Mini Basic)
-- vim.o.termguicolors = true

-- Misc UI Settings
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.scrolloff = 4

-- Statusline
vim.o.laststatus = 3
vim.o.cmdheight = 0
