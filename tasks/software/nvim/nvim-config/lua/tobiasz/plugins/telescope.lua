return {
  -- Telescope
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-project.nvim",
    "nvim-telescope/telescope-node-modules.nvim",
    "nvim-telescope/telescope-dap.nvim",
    {
      "dhruvmanila/telescope-bookmarks.nvim",
      dependencies = { "kkharji/sqlite.lua" },
    },
    "xiyaowong/telescope-emoji.nvim",
    {
      "nvim-telescope/telescope-github.nvim",
      dependencies = {
        { "nvim-lua/plenary.nvim" },
      },
    },
    "ThePrimeagen/harpoon",
    "ThePrimeagen/refactoring.nvim",
    "ThePrimeagen/git-worktree.nvim",
  },
  config = function()
    require("tobiasz.config.telescope")

    local with_maker = require("tobiasz.config.telescope.entry-makers").with_entry_maker
    local string_util = require("tobiasz.utils.string-util")

    VMap.map("<C-p>", require("tobiasz.config.telescope.pickers").project_files)
    VMap.nmap("<leader>pc", with_maker("java", require("tobiasz.config.telescope.pickers").project_files))
    VMap.nmap("<leader>pa", require("telescope.builtin").builtin)

    VMap.nmap("<leader>pw", function()
      require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
    end)
    VMap.nmap("<leader>ps", function()
      vim.ui.input({ prompt = "Grep For > " }, function(input)
        if not string_util.is_empty(input) then
          require("telescope.builtin").grep_string({ search = input })
        end
      end)
    end)

    VMap.nmap("<leader>pls", require("telescope.builtin").live_grep)
    VMap.nmap("<leader>pf", with_maker("file", require("telescope.builtin").find_files))

    VMap.map("<C-f>", require("telescope.builtin").current_buffer_fuzzy_find)

    VMap.nmap("<leader>hh", require("telescope.builtin").help_tags)
    VMap.nmap("<leader>man", require("telescope.builtin").man_pages)

    -- git
    VMap.nmap("<leader>gb", require("telescope.builtin").git_branches)
    VMap.nmap("<leader>gl", require("telescope.builtin").git_commits)
    VMap.nmap("<leader>gs", require("telescope.builtin").git_status)

    -- lsp
    VMap.nmap("gd", with_maker("references", require("tobiasz.config.telescope.pickers").definitions))
    VMap.nmap("gr", with_maker("references", require("tobiasz.config.lsp-config.handlers").go_to_references))
    VMap.nmap("gi", with_maker("references", require("telescope.builtin").lsp_implementations))

    -- custom
    VMap.nmap("<leader>vrc", require("tobiasz.config.telescope.pickers").search_vimrc)

    -- extensions
    VMap.nmap("<leader>pp", require("telescope").extensions.project.project)
    VMap.nmap("<leader>nm", require("telescope").extensions.node_modules.list)
    VMap.nmap("<leader>pb", require("telescope").extensions.bookmarks.bookmarks)
    VMap.nmap("<leader>pe", require("telescope").extensions.emoji.emoji)
    VMap.nmap("<leader>sb", require("telescope").extensions.dap.list_breakpoints)
    VMap.nmap("<leader>sf", require("telescope").extensions.dap.frames)
    VMap.vmap("<C-r>", require("telescope").extensions.refactoring.refactors, { expr = false })

    -- Git worktrees
    VMap.nmap("<leader>.", require("telescope").extensions.git_worktree.git_worktrees)
    VMap.nmap("<leader><leader>.", require("telescope").extensions.git_worktree.create_git_worktree)
  end,
}
