-- Inspired from https://gitlab.com/domsch1988/mvim and https://github.com/nvim-lua/kickstart.nvim


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
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.scrolloff = 4

-- Statusline
vim.o.laststatus = 3
vim.o.cmdheight = 0

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
require("lazy").setup({
    {
      "echasnovski/mini.nvim",
      version = false,
			dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
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
            cursor = {
                timing = animate.gen_timing.cubic({ duration = 50, unit = 'total' })
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
        require('mini.completion').setup({
            window = {
                info = { border = 'rounded'},
                signature = { border = 'rounded'},
            }
        })
        require('mini.colors').setup()
        require('mini.trailspace').setup()
        require('mini.fuzzy').setup()
        require('mini.clue').setup({
            triggers = {
            -- Leader triggers
							{ mode = 'n', keys = '<Leader>' },
							{ mode = 'x', keys = '<Leader>'},

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
              { mode = 'n', keys = '<Leader>f', desc = 'Find' },
              { mode = 'n', keys = '<Leader>b', desc = 'Buffer' },
							require('mini.clue').gen_clues.builtin_completion(),
							require('mini.clue').gen_clues.g(),
							require('mini.clue').gen_clues.marks(),
							require('mini.clue').gen_clues.registers(),
							require('mini.clue').gen_clues.windows(),
							require('mini.clue').gen_clues.z(),
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
				require('mini.hipatterns').setup({
					highlighters = {
						-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
						fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
						hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
						todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
						note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

						-- Highlight hex color strings (`#rrggbb`) using that color
						hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
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
                choose_in_vsplit  = '<C-CR>',
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
      -- Highlight, edit, and navigate code
      'nvim-treesitter/nvim-treesitter',
      dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
      },
      build = ':TSUpdate',
    },
})

-- Colorscheme
if vim.o.background == 'dark' then
  palette = {
    base00 = '#1e1e2e' ,
    base01 = '#181825' ,
    base02 = '#313244' ,
    base03 = '#45475a' ,
    base04 = '#585b70' ,
    base05 = '#cdd6f4' ,
    base06 = '#f5e0dc' ,
    base07 = '#b4befe' ,
    base08 = '#f38ba8' ,
    base09 = '#fab387' ,
    base0A = '#f9e2af' ,
    base0B = '#a6e3a1' ,
    base0C = '#94e2d5' ,
    base0D = '#89b4fa' ,
    base0E = '#cba6f7' ,
    base0F = '#f2cdcd'
  }
  use_cterm = {
    base00 = 235,
    base01 = 238,
    base02 = 241,
    base03 = 102,
    base04 = 250,
    base05 = 252,
    base06 = 254,
    base07 = 231,
    base08 = 186,
    base09 = 136,
    base0A = 29,
    base0B = 115,
    base0C = 132,
    base0D = 153,
    base0E = 218,
    base0F = 67,
  }
end

-- Light palette is an 'inverted dark', output of 'MiniBase16.mini_palette':
-- - Background '#C0D2D2' (LCh(uv) = 83-10-192)
-- - Foreground '#262626' (Lch(uv) = 15-0-0)
-- - Accent chroma 80
if vim.o.background == 'light' then
  palette = {
    base00 = '#1e1e2e',
    base01 = '#181825',
    base02 = '#313244',
    base03 = '#45475a',
    base04 = '#585b70',
    base05 = '#cdd6f4',
    base06 = '#f5e0dc',
    base07 = '#b4befe',
    base08 = '#f38ba8',
    base09 = '#fab387',
    base0A = '#f9e2af',
    base0B = '#a6e3a1',
    base0C = '#94e2d5',
    base0D = '#89b4fa',
    base0E = '#cba6f7',
    base0F = '#f2cdcd'
  }
  use_cterm = {
    base00 = 252,
    base01 = 248,
    base02 = 102,
    base03 = 241,
    base04 = 237,
    base05 = 235,
    base06 = 234,
    base07 = 232,
    base08 = 235,
    base09 = 94,
    base0A = 29,
    base0B = 22,
    base0C = 126,
    base0D = 25,
    base0E = 89,
    base0F = 25,
  }
end

if palette then
  require('mini.base16').setup({ palette = palette, use_cterm = use_cterm })
  vim.g.colors_name = 'catppuccin'
end

-- vim.cmd[[colorscheme catppuccin]]


-- Autocommands
-- Automatically close terminal Buffers when their Process is done
vim.api.nvim_create_autocmd("TermClose", {
    callback = function()
       vim.cmd("bdelete")
    end
})

vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesWindowOpen',
    callback = function(args)
    local win_id = args.data.win_id

    -- Customize window-local settings
    vim.wo[win_id].winblend = 10
    vim.api.nvim_win_set_config(win_id, { border = 'rounded' })
    end,
})

-- local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
-- vim.api.nvim_create_autocmd('TextYankPost', {
--   callback = function()
--     vim.highlight.on_yank()
--   end,
--   group = highlight_group,
--   pattern = '*',
-- })


-- Keymaps
local keymap = vim.api.nvim_set_keymap

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- File Picker
keymap("n", "<leader>ff", "<cmd>lua MiniPick.builtin.files()<cr>", { noremap = true, silent = true , desc = 'Find File'})
keymap("n", "<leader>fm", "<cmd>lua MiniFiles.open()<cr>", { noremap = true, silent = true , desc = 'Find Manualy'})
keymap("n", "<leader>fb", "<cmd>lua MiniPick.builtin.buffers()<cr>", { noremap = true, silent = true , desc = 'Find Buffer'})
keymap("n", "<leader>fs", "<cmd>lua MiniPick.builtin.grep_live()<cr>", { noremap = true, silent = true , desc = 'Find String'})
keymap("n", "<leader>fh", "<cmd>lua MiniPick.builtin.help()<cr>", { noremap = true, silent = true , desc = 'Find Help'})

-- Buffer Related Keymaps
keymap("n", "<leader>bd", "<cmd>bd<cr>", { noremap = true, silent = true , desc = 'Close Buffer'})
keymap("n", "<leader>bn", "<cmd>bnext<cr>", { silent = true , desc = 'Next Buffer'})
keymap("n", "<leader>bp", "<cmd>bprevious<cr>", { silent = true , desc = 'Previous Buffer'})

-- Treesitter
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)
