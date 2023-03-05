return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    local on_attach = require("tobiasz.config.lsp-config.config").on_attach

    null_ls.setup({
      on_attach = on_attach,
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.prettierd.with({
          prefer_local = "node_modules/.bin",
        }),
        null_ls.builtins.formatting.google_java_format.with({
          extra_args = {
            "--aosp",
          },
        }),
        null_ls.builtins.formatting.xmllint,
      },
    })

    vim.env.XMLLINT_INDENT = "    "
  end,
}
