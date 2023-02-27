return {
  "tjdevries/colorbuddy.vim",
  config = function()
    require("colorbuddy").setup()
    local colorbuddy = require("colorbuddy")
    colorbuddy.colorscheme("tobiasz.themes.second_theme")

    local signs = { Error = "", Warn = "", Hint = "", Info = "" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
  end,
}
