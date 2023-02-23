return {
  "nvim-lua/plenary.nvim",
  config = function ()
    VMap.nmap("<leader>pt", "<Plug>PlenaryTestFile<CR>")
  end,
}
