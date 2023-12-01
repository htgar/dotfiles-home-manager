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

-- Covered by Mini Basics
-- local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
-- vim.api.nvim_create_autocmd('TextYankPost', {
--   callback = function()
--     vim.highlight.on_yank()
--   end,
--   group = highlight_group,
--   pattern = '*',
-- })
