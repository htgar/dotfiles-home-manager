-- Keymaps
local keymap = vim.api.nvim_set_keymap

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- File Picker
keymap('n', '<leader>e', '<cmd>lua MiniFiles.open()<cr>', { noremap = true, silent = true , desc = 'Explore'})

keymap('n', '<leader>ff', '<cmd>lua MiniPick.builtin.files()<cr>', { noremap = true, silent = true , desc = 'Find Files'})
keymap('n', '<leader>fb', '<cmd>lua MiniPick.builtin.buffers()<cr>', { noremap = true, silent = true , desc = 'Find Buffer'})
keymap('n', '<leader>fs', '<cmd>lua MiniPick.builtin.grep_live()<cr>', { noremap = true, silent = true , desc = 'Find String'})
keymap('n', '<leader>fh', '<cmd>lua MiniPick.builtin.help()<cr>', { noremap = true, silent = true , desc = 'Find Help'})

-- Buffer Related Keymaps
keymap('n', '<leader>bd', '<cmd>bd<cr>', { noremap = true, silent = true , desc = 'Close Buffer'})
keymap('n', '<leader>bn', '<cmd>bnext<cr>', { silent = true , desc = 'Next Buffer'})
keymap('n', '<leader>bp', '<cmd>bprevious<cr>', { silent = true , desc = 'Previous Buffer'})

-- Git Related Keymaps
keymap('n', '<leader>gg', '<cmd>terminal lazygit<cr>', { noremap = true, silent = true , desc = 'Lazygit'})
keymap('n', '<leader>gp', '<cmd>terminal git pull<cr>', { noremap = true, silent = true , desc = 'Git Push'})
keymap('n', '<leader>gs', '<cmd>terminal git push<cr>', { noremap = true, silent = true , desc = 'Git Pull'})
keymap('n', '<leader>ga', '<cmd>terminal git add .<cr>', { noremap = true, silent = true , desc = 'Git Add All'})
keymap("n", "<leader>gc", '<cmd>terminal git commit<cr>', { noremap = true, silent = true , desc = 'Git Commit'})

