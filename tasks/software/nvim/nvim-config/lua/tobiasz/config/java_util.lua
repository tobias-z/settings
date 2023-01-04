local luasnip = require("luasnip")
local lsp_config = require("tobiasz.config.lsp-config.config")

local function nvim_feedkeys(keys, opts)
  local replaced = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(replaced, opts or "n", true)
end

require("java_util").setup({
  jdtls = {
    -- jdtls_location = "/home/tobiasz/dev/java/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository",
    lombok_support = true,
    config = {
      capabilities = lsp_config.capabilities,
      on_attach = function(client, bufnr)
        local jdtls = require("jdtls")
        jdtls.setup_dap({ hotcodereplace = "auto" })
        jdtls.setup.add_commands()
        require("tobiasz.config.lsp-config.config").on_attach(client, bufnr)
        local opts = { silent = true, buffer = bufnr }
        vim.keymap.set("n", "<leader>oi", jdtls.organize_imports)
        vim.keymap.set("v", "<leader>rv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
        vim.keymap.set("n", "<leader>rv", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
        vim.keymap.set("v", "<leader>rc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", opts)
        vim.keymap.set("n", "<leader>rc", "<Cmd>lua require('jdtls').extract_constant()<CR>", opts)
        vim.keymap.set("v", "<leader>rm", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], opts)
        vim.keymap.set("n", "<leader>rm", [[<ESC><CMD>lua require('jdtls').extract_method()<CR>]], opts)
        require("jdtls.dap").setup_dap_main_class_configs()
      end,
    },
  },
  springboot = {
    enable = false,
    boot_ls = {
      on_attach = function(client, bufnr)
        require("tobiasz.config.lsp-config.config").on_attach(client, bufnr)
      end,
    },
  },
  test = {
    use_defaults = true,
    after_snippet = function(opts)
      local has_jdtls, jdtls = pcall(require, "jdtls")
      if not has_jdtls then
        return
      end

      jdtls.organize_imports()
      if opts.is_luasnip then
        vim.defer_fn(function()
          local mode = vim.fn.mode()
          if mode == "n" then
            nvim_feedkeys("a")
          elseif mode == "s" then
            nvim_feedkeys("<esc>evb<C-G>")
          end
        end, 300)
      end
    end,
    class_snippets = {
      ["With test"] = function(info)
        return luasnip.parser.parse_snippet(
          "_",
          string.format(
            [[
package %s;

public class %s {

    @BeforeEach
    void setup() {
      // setup
    }

    @Test
    void ${2:helloWorld}() {
      $0
    }
}
                      ]],
            info.package,
            info.classname
          )
        )
      end,
    },
  },
})
