return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",
  },
  config = function ()
    local dap = require("dap")

    require("nvim-dap-virtual-text").setup({})

    local dapui = require("dapui")

    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸" },
      mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      expand_lines = vim.fn.has("nvim-0.7"),
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.70,
            },
            -- { id = "breakpoints", size = 0.35 },
            -- { id = "stacks", size = 0.35 },
            { id = "watches", size = 0.35 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            -- "repl",
            "console",
            -- { id = "console", size = 0.50 },
          },
          size = 10,
          position = "bottom",
        },
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil, -- Can be integer or nil.
      },
    })

    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({})
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close({})
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close({})
    end

    VMap.nmap("<leader>sn", require("dap").continue)
    VMap.nmap("<leader>sa", require("dap").toggle_breakpoint)
    VMap.nmap("<leader>sj", require("dap").step_over)
    VMap.nmap("<leader>sk", require("dap").step_back)
    VMap.nmap("<leader>sl", require("dap").step_into)
    VMap.nmap("<leader>sh", require("dap").step_out)
    VMap.nmap("<leader>ssb", require("dap").clear_breakpoints)
    VMap.nmap("<leader>sc", require("dap").run_to_cursor)
    VMap.nmap("<leader>sr", function()
      require("dap.repl").toggle({}, "vsplit")
    end)
    VMap.nmap("<leader>st", require("dapui").toggle)
    VMap.nmap("<leader>se", require("dapui").eval)

    require("tobiasz.debuggers")
  end,
}
