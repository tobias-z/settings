return {
  "kyazdani42/nvim-tree.lua",
  dependencies = {
    "antosha417/nvim-lsp-file-operations",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local lib = require("nvim-tree.lib")
    local view = require("nvim-tree.view")

    local function collapse_all()
      require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
    end

    local function edit_or_open()
      local action = "edit"
      local node = lib.get_node_at_cursor()

      if node == nil then
        return
      end

      if node.link_to and not node.nodes then
        require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
        view.close()
      elseif node.nodes ~= nil then
        lib.expand_or_collapse(node)
      else
        require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
        view.close()
      end
    end

    require("nvim-tree").setup({
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
        vim.keymap.set("n", "l", edit_or_open, opts("EditOrOpen"))
        vim.keymap.set("n", "H", collapse_all, opts("CollapseAll"))
      end,
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = { hint = "", info = "", warning = "", error = "" },
      },
      filters = {
        custom = {
          "node_modules",
          "\\.git$",
        },
      },
      git = {
        enable = false,
        ignore = false,
      },
      renderer = {
        group_empty = true,
        icons = {
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = " ",
              open = " ",
              empty = "  ",
              empty_open = " ",
              symlink = " ",
              symlink_open = " ",
            },
          },
        },
      },
      view = {
        side = "left",
        hide_root_folder = false,
        width = 40,
        adaptive_size = true,
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
    })

    require("lsp-file-operations").setup({
      debug = false,
    })

    VMap.nmap("<C-b>", ":NvimTreeFindFileToggle<CR>")
    VMap.imap("<C-b>", "<cmd>NvimTreeFindFileToggle<CR><Esc>")
  end,
}
