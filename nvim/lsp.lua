-- Setup language servers.
local lspconfig = require('lspconfig')

-- Nix
require 'lspconfig'.rnix.setup {}

-- Lua Setup
require 'lspconfig'.lua_ls.setup {
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
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

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>lf', vim.diagnostic.open_float, {desc = 'LSP: Open Floating Diagnostic'})
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {desc = 'Go to prev diagnostic'})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {desc = 'Go to next diagnostic'})
vim.keymap.set('n', '<space>lq', vim.diagnostic.setloclist, {desc = 'LSP: Set Local List'})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = 'Go to Declaration'})
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = 'Go to Definition'})
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = 'Show Hover Info'})
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = ev.buf, desc = 'Show Implementation'})
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = 'Show Signature Help'})
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { buffer = ev.buf, desc = 'Workspace: Add Folder'})
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf, desc = 'Workspace: Remove Folder'})
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { buffer = ev.buf, desc = 'Workspace: List Folders'})
		vim.keymap.set('n', '<space>ld', vim.lsp.buf.type_definition, { buffer = ev.buf, desc = 'LSP: Show Type Definition'})
		vim.keymap.set('n', '<space>lr', vim.lsp.buf.rename, { buffer = ev.buf, desc = 'LSP: Rename Symbol'})
		vim.keymap.set({ 'n', 'v' }, '<space>lc', vim.lsp.buf.code_action, { buffer = ev.buf, desc = 'LSP: Code Action'})
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = ev.buf, desc = 'LSP: List References'})
		vim.keymap.set('n', '<space>lf', function()
			vim.lsp.buf.format { async = true }
		end, { buffer = ev.buf, desc = 'LSP: Format Buffer'})
	end,
})
