vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- UI Stuff
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin"
    end
  },

  { "nvim-tree/nvim-web-devicons" },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup{
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
          end, {expr=true, desc="Next Git Hunk"})

          map("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
          end, {expr=true, desc="Prev Git Hunk"})

          -- Text object
          map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>", {desc="Git Hunk"})
        end
      }
    end
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end
  },

  -- Whichkey

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  -- Mini 

  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.basics").setup()
      require("mini.ai").setup()
      require("mini.bracketed").setup()
      require("mini.comment").setup()
      require("mini.cursorword").setup()
      require("mini.statusline").setup()
      require("mini.files").setup{
        options = {
          use_as_default_explorer = false,
        }
      }
    end
  },

  -- Oil
  {
    'stevearc/oil.nvim',
    opts = {},
    config = function()
      require("oil").setup()
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
  },

  -- Telescope

  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {"bash", "regex", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn", -- set to `false` to disable one of the mappings
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
    end
  },

  -- LSP 
  { "neovim/nvim-lspconfig" },
})

-- Options (Not covered by Mini Basic)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.relativenumber = true

-- LSP and Keymaps Setup
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.rnix.setup {}
lspconfig.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
}

-- Keymaps Setup
require("which-key").register({
  f = {
    name = "File", -- optional group name
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
    m = { function() MiniFiles.open() end, "Mini Files" },
  },
  t = {
    name = "Trouble",
    t = { function() require("trouble").toggle() end, "Toggle Trouble" },
    w = { function() require("trouble").toggle("workspace_diagnostics") end, "Workspace Diagnostics" },
    d = { function() require("trouble").toggle("document_diagnostics") end, "Document Diagnostics" },
    q = { function() require("trouble").toggle("quickfix") end, "Quickfix List" },
    l = { function() require("trouble").toggle("loclist") end, "Local List" },
  },
}, { prefix = "<leader>" })

vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end, {desc = "LSP References (Trouble)"})

-- Keymaps on LSPAttach
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = "GoTo Declaration" })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = "GoTo Definition" })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = "Show Hover" })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = ev.buf, desc = "GoTo Implementation" })
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = ev.buf , desc = "Show Signature Help"})
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { buffer = ev.buf, desc = "Add Workspace Folder" })
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf, desc = "Remove Workspace Folder" })
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { buffer = ev.buf, desc = "List Workspace Folders" })
    vim.keymap.set('n', '<space>ld', vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "LSP Type Definition"})
    vim.keymap.set('n', '<space>ln', vim.lsp.buf.rename, { buffer = ev.buf, desc = "LSP Rename"})
    vim.keymap.set({ 'n', 'v' }, '<space>lc', vim.lsp.buf.code_action, { buffer = ev.buf, desc = "LSP CodeAction"})
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = ev.buf, desc = "LSP References" })
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, { buffer = ev.buf })
  end,
})
