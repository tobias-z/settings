return {
  "rcarriga/nvim-notify",
  config = function ()
    local notify = require("notify")
    notify.setup({
      background_colour = "#000000",
      level = "WARN",
      stages = "static",
      on_open = nil,
      on_close = nil,
      render = "default",
      timeout = 5000,
      max_width = 100,
      max_height = nil,
      minimum_width = 50,
      icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
      },
    })

    vim.notify = notify
  end,
}
