return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-nvim-lsp",
    "jose-elias-alvarez/nvim-lsp-ts-utils",
  },
  config = function ()
    require("tobiasz.config.lsp-config")
  end,
}
