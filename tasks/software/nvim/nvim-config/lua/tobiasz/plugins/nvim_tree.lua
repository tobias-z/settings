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

        -- mark operation
        local mark_move_j = function()
          api.marks.toggle()
          vim.cmd("norm j")
        end
        local mark_move_k = function()
          api.marks.toggle()
          vim.cmd("norm k")
        end

        local mark_remove = function()
          local marks = api.marks.list()
          if #marks == 0 then
            table.insert(marks, api.tree.get_node_under_cursor())
          end
          vim.ui.input({ prompt = string.format("Remove/Delete %s files? [y/n] ", #marks) }, function(input)
            if input == "y" then
              for _, node in ipairs(marks) do
                api.fs.remove(node)
              end
              api.marks.clear()
              api.tree.reload()
            end
          end)
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
        vim.keymap.set("n", "l", edit_or_open, opts("EditOrOpen"))
        vim.keymap.set("n", "H", collapse_all, opts("CollapseAll"))

        vim.keymap.set("n", "J", mark_move_j, opts("Toggle Bookmark Down"))
        vim.keymap.set("n", "K", mark_move_k, opts("Toggle Bookmark Up"))
        vim.keymap.del('n', 'd', { buffer = bufnr })
        vim.keymap.set("n", "dm", mark_remove, opts("Remove File(s)"))
        vim.keymap.set("n", "dd", function()
          local file = api.tree.get_node_under_cursor()
          vim.ui.input({ prompt = string.format("Delete file %s [y/n] ", file.name) }, function(input)
            if input == "y" then
              api.fs.remove(file)
              api.tree.reload()
            end
          end)
        end, opts("Remove File(s)"))
      end,
      ui = {
        confirm = {
          remove = false,
        },
      },
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
          show = {
            file = false,
            folder = false,
            folder_arrow = false,
          },
          -- glyphs = {
          --   default = "",
          --   symlink = "",
          --   bookmark = "",
          --   folder = {
          --     arrow_closed = "",
          --     arrow_open = "",
          --     default = " ",
          --     open = " ",
          --     empty = "  ",
          --     empty_open = " ",
          --     symlink = " ",
          --     symlink_open = " ",
          --   },
          -- },
        },
      },
      view = {
        side = "left",
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
