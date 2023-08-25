return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    signs = false,
    gui_style = {
      fg = "BOLD", -- The gui style to use for the fg highlight group.
      bg = "NONE", -- The gui style to use for the bg highlight group.
    },
    highlight = {
      keyword = "fg",
      after = "",
    },
  },
}
