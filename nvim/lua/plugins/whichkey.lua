return {
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
  },
  config = function()
	local wk = require("which-key")
	
	wk.register({
	  f = {
	    name = "file", -- optional group name
	    f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
	    g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
	    m = { function() MiniFiles.open() end, "Mini Files" },
	  },
	}, { prefix = "<leader>" })

	end
}
}
