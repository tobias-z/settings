return {
  "scalameta/nvim-metals",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local metals_config = require("metals").bare_config()
    metals_config.settings = {
      showImplicitArguments = true,
      excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
    }
    metals_config.init_options.statusBarProvider = "on"
    local config = require("tobiasz.config.lsp-config.config")
    metals_config.capabilities = config.capabilities
    metals_config.on_attach = function(client, bufnr)
      config.on_attach(client, bufnr)
      require("metals").setup_dap()
    end

    -- Autocmd that will actually be in charging of starting the whole thing
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      -- NOTE: You may or may not want java included here. You will need it if you
      -- want basic Java support but it may also conflict if you are using
      -- something like nvim-jdtls which also works on a java filetype autocmd.
      pattern = { "scala", "sbt" },
      callback = function()
        require("metals").initialize_or_attach(metals_config)
        VMap.nmap("<leader>vk", require("metals").hover_worksheet)
        VMap.nmap("<leader>vn", require("telescope").extensions.metals.commands)
      end,
      group = nvim_metals_group,
    })

    require("telescope").load_extension("metals")
  end,
}
