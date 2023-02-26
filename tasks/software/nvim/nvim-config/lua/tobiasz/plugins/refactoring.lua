return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("refactoring").setup({
      -- prompt for return type
      prompt_func_return_type = {
        go = true,
        cpp = true,
        c = true,
        java = true,
      },
      -- prompt for function parameters
      prompt_func_param_type = {
        go = true,
        cpp = true,
        c = true,
        java = true,
        typescript = true,
      },
    })

    local opts = { expr = false }

    VMap.vmap("<leader>rm", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], opts)
    VMap.vmap("<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], opts)
    VMap.vmap("<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], opts)

    VMap.nmap("<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], opts)
    VMap.nmap("<leader>rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]], opts)

    VMap.vmap("<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], opts)
    VMap.nmap("<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], opts)
  end,
}
