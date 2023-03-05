return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",
    "barreiroleo/ltex-extra.nvim",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "rcarriga/cmp-dap",
    "petertriho/cmp-git",
    "nvim-lua/plenary.nvim",
    "L3MON4D3/LuaSnip",
  },
  config = function()
    local luasnip = require("luasnip")
    local cmp = require("cmp")

    local lspkind_comparator = function(conf)
      local lsp_types = require("cmp.types").lsp
      return function(entry1, entry2)
        print(entry1.source.name)
        if entry1.source.name ~= "nvim_lsp" then
          if entry2.source.name == "nvim_lsp" then
            return false
          else
            return nil
          end
        end
        local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
        local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]

        local priority1 = conf.kind_priority[kind1] or 0
        local priority2 = conf.kind_priority[kind2] or 0
        if priority1 == priority2 then
          return nil
        end
        return priority2 < priority1
      end
    end

    local label_comparator = function(entry1, entry2)
      return entry1.completion_item.label < entry2.completion_item.label
    end

    local cmp_kinds = {
      Text = "",
      Method = "M",
      Function = "M",
      Constructor = "M",
      Field = "F",
      Variable = "V",
      Class = "C",
      Interface = "I",
      Module = "",
      Property = "P",
      Unit = "",
      Value = "",
      Enum = "E",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "F",
      Constant = "F",
      Struct = "S",
      Event = "",
      Operator = "",
      TypeParameter = "",
    }

    -- if vim.env.HOME:find("Users") then
    -- 	cmp_kinds = {
    -- 		Text = "",
    -- 		Method = "",
    -- 		Function = "",
    -- 		Constructor = "",
    -- 		Field = "",
    -- 		Variable = "",
    -- 		Class = "ﴯ",
    -- 		Interface = "",
    -- 		Module = "",
    -- 		Property = "ﰠ",
    -- 		Unit = "",
    -- 		Value = "",
    -- 		Enum = "",
    -- 		Keyword = "",
    -- 		Snippet = "",
    -- 		Color = "",
    -- 		File = "",
    -- 		Reference = "",
    -- 		Folder = "",
    -- 		EnumMember = "",
    -- 		Constant = "",
    -- 		Struct = "",
    -- 		Event = "",
    -- 		Operator = "",
    -- 		TypeParameter = "",
    -- 	}
    -- end

    cmp.setup({
      enabled = function()
        return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
      end,
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(_, vim_item)
          vim_item.kind = cmp_kinds[vim_item.kind] or ""
          return vim_item
        end,
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      -- window = {
      -- 	completion = cmp.config.window.bordered(),
      -- 	documentation = cmp.config.window.bordered(),
      -- },
      mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs( -4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item()),
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item()),
        ["<C-Space>"] = cmp.mapping.complete(),
        -- ["<CR>"] = cmp.mapping.confirm({
        --   -- behavior = cmp.ConfirmBehavior.Replace,
        --   select = true,
        -- }),
        ["<Esc>"] = cmp.mapping.close(),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({
              select = true,
              -- behavior = cmp.ConfirmBehavior.Replace,
            })
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-j>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable( -1) then
            luasnip.jump( -1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "dap" },
        { name = "crates" },
      }, {
        { name = "git" },
        { name = "path" },
        { name = "buffer" },
      }),
      -- sorting = {
      --   comparators = {
      --     lspkind_comparator({
      --       kind_priority = {
      --         Field = 11,
      --         Property = 11,
      --         Constant = 10,
      --         Enum = 10,
      --         EnumMember = 10,
      --         Event = 10,
      --         Function = 10,
      --         Method = 10,
      --         Operator = 10,
      --         Reference = 10,
      --         Struct = 10,
      --         Variable = 9,
      --         File = 8,
      --         Folder = 8,
      --         Class = 5,
      --         Color = 5,
      --         Module = 5,
      --         Keyword = 2,
      --         Constructor = 1,
      --         Interface = 1,
      --         Snippet = 0,
      --         Text = 1,
      --         TypeParameter = 1,
      --         Unit = 1,
      --         Value = 1,
      --       },
      --     }),
      --     label_comparator,
      --   },
      -- },
    })

    require("cmp_git").setup()
  end,
}
