return {
  "saecki/crates.nvim",
  tag = "v0.3.0",
  config = function()
    require("crates").setup({
      null_ls = {
        enabled = true,
        name = "crates.nvim",
      },
    })
  end,
}
