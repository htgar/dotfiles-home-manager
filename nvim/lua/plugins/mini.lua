return {
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
      require("mini.files").setup({
        options = {
          use_as_default_explorer = true,
        }
      })
    end
  },
}
