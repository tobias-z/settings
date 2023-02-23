return {
  "numToStr/Comment.nvim",
  dependencies = {
    "tjdevries/vim-inyoface",
  },
  config = function ()
    require("Comment").setup({})
    VMap.nmap("<leader>cc", ":call inyoface#toggle_comments()<CR>")
  end,
}
