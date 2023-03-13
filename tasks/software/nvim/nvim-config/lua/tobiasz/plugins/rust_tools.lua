return {
  "simrat39/rust-tools.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
  },
  config = function()
    local rt = require("rust-tools")

    local extension_path = vim.env.HOME .. "/.vscodium-insiders/extensions/vadimcn.vscode-lldb-1.9.0-universal/"
    local codelldb_path = extension_path .. "adapter/codelldb"
    local liblldb_path = extension_path .. "lldb/lib/liblldb.so" -- MacOS: This may be .dylib

    rt.setup({
      dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
      },
      server = {
        cmd = {
          "rustup",
          "run",
          "nightly",
          "rust-analyzer",
        },
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
            procMacro = {
              enable = true,
            },
            diagnostics = {
              enable = true,
              disabled = { "unresolved-proc-macro" },
              enableExperimental = true,
              warningsAsHint = {},
            },
          },
        },
        on_attach = function(client, bufnr)
          require("tobiasz.config.lsp-config.config").on_attach(client, bufnr)
          vim.keymap.set("n", "<leader>sp", rt.debuggables.debuggables, { buffer = bufnr })
          vim.keymap.set("n", "<leader>ti", rt.runnables.runnables, { buffer = bufnr })
        end,
      },
      tools = {
        inlay_hints = {
          auto = false,
        },
      },
    })
  end,
}
