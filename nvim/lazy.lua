-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)


-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
	{
		'echasnovski/mini.nvim',
		version = false,
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('mini.ai').setup()
			require('mini.bracketed').setup()
			require('mini.statusline').setup({
				use_icons = true
			})
			local animate = require('mini.animate')
			animate.setup {
				scroll = {
					-- Disable Scroll Animations, as the can interfer with mouse Scrolling
					enable = false,
				},
			}
			require('mini.basics').setup({
				options = {
					extra_ui = false,
					win_borders = 'double',
				},
				mappings = {
					windows = true,
					move_with_alt = true,
				}
			})
			require('mini.comment').setup()
			require('mini.trailspace').setup()
			require('mini.fuzzy').setup()
			local clue = require('mini.clue')
			clue.setup({
				triggers = {
					-- Leader triggers
					{ mode = 'n', keys = '<Leader>' },
					{ mode = 'x', keys = '<Leader>' },

					-- Built-in completion
					{ mode = 'i', keys = '<C-x>' },

					-- `g` key
					{ mode = 'n', keys = 'g' },
					{ mode = 'x', keys = 'g' },

					-- `s` key
					{ mode = 'n', keys = 's' },
					{ mode = 'x', keys = 's' },

					-- Bracketed key
					{ mode = 'n', keys = '[' },
					{ mode = 'x', keys = '[' },
					{ mode = 'n', keys = ']' },
					{ mode = 'x', keys = ']' },

					-- Marks
					{ mode = 'n', keys = "'" },
					{ mode = 'n', keys = '`' },
					{ mode = 'x', keys = "'" },
					{ mode = 'x', keys = '`' },

					-- Registers
					{ mode = 'n', keys = '"' },
					{ mode = 'x', keys = '"' },
					{ mode = 'i', keys = '<C-r>' },
					{ mode = 'c', keys = '<C-r>' },

					-- Window commands
					{ mode = 'n', keys = '<C-w>' },

					-- `z` key
					{ mode = 'n', keys = 'z' },
					{ mode = 'x', keys = 'z' },
				},

				clues = {
					{ mode = 'n', keys = '<Leader>b', desc = 'Buffer' },
					{ mode = 'n', keys = '<Leader>f', desc = 'Find' },
					{ mode = 'n', keys = '<Leader>g', desc = 'Git' },
					{ mode = 'n', keys = '<Leader>l', desc = 'LSP' },
					{ mode = 'n', keys = '<Leader>t', desc = 'Treesitter' },
					clue.gen_clues.builtin_completion(),
					clue.gen_clues.g(),
					clue.gen_clues.marks(),
					clue.gen_clues.registers(),
					clue.gen_clues.windows(),
					clue.gen_clues.z(),
				},
				window = {
					delay = 300
				}
			})
			require('mini.cursorword').setup()
			require('mini.files').setup({
				mappings = {
					go_in_plus = '<CR>',
				},
			})
			require('mini.extra').setup()
			local hipatterns = require('mini.hipatterns')
			hipatterns.setup({
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
					hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
					todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
					note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})
			require('mini.indentscope').setup({
				draw = {
					animation = function(s, n) return 5 end,
				},
				symbol = "│"
			})
			require('mini.jump').setup()
			require('mini.pairs').setup()
			require('mini.pick').setup({
				mappings = {
					choose_in_vsplit = '<C-CR>',
				},
				options = {
					use_cache = true
				},
				window = {
					config = {
						border = 'rounded'
					},
				}
			})
			require('mini.surround').setup()
			-- require('mini.tabline').setup()
		end
	},
	{
		-- Colorscheme
		'catppuccin/nvim',
		name = 'catppuccin',
		priority = 1000,
		config = function() vim.cmd.colorscheme "catppuccin" end
	},
	{
		-- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
	},
	{
		-- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ 'j-hui/fidget.nvim', opts = {} },
		},
	},
	-- Git
	{
		'lewis6991/gitsigns.nvim',
		config = function() require('gitsigns').setup() end
	},
})
