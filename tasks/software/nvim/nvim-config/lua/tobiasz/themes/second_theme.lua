local Color = require("colorbuddy").Color

Color.new("white", "#E0E0E0")
Color.new("red", "#cc6666")
Color.new("pink", "#fef601")
Color.new("green", "#99cc99")
Color.new("yellow", "#f8fe7a")
Color.new("blue", "#81a2be")
Color.new("aqua", "#8ec07c")
Color.new("cyan", "#8abeb7")
Color.new("purple", "#8e6fbd")
Color.new("violet", "#b294bb")
Color.new("orange", "#de935f")
Color.new("brown", "#a3685a")

Color.new("seagreen", "#698b69")
Color.new("turquoise", "#698b69")

Color.new("string", "#989A24")
Color.new("darkgreen", "#779E69")

local c = require("colorbuddy.color").colors
local Group = require("colorbuddy.group").Group
local g = require("colorbuddy.group").groups
local s = require("colorbuddy.style").styles

Group.new("identifier", c.white)
Group.new("function", c.blue)
Group.new("macro", c.blue)
Group.new("@variable.builtin", c.yellow)
Group.new("@method.call", c.blue, nil, s.bold)
Group.new("@repeat", c.red)
Group.new("@keyword", c.red)
Group.new("@conditional", c.red)

Group.new("GoTestSuccess", c.green, nil, s.bold)
Group.new("GoTestFail", c.red, nil, s.bold)

-- Group.new('Keyword', c.purple, nil, nil)

Group.new("TSPunctBracket", c.orange:light():light())

Group.new("StatuslineError1", c.red:light():light(), g.Statusline)
Group.new("StatuslineError2", c.red:light(), g.Statusline)
Group.new("StatuslineError3", c.red, g.Statusline)
Group.new("StatuslineError3", c.red:dark(), g.Statusline)
Group.new("StatuslineError3", c.red:dark():dark(), g.Statusline)

Group.new("pythonTSType", c.red)
Group.new("goTSType", g.Type.fg:dark(), nil, g.Type)

Group.new("typescriptTSConstructor", g.pythonTSType)
Group.new("typescriptTSProperty", c.blue)

-- vim.cmd([[highlight WinSeparator guifg=#4e545c guibg=None]])
Group.new("WinSeparator", nil, nil)

Group.new("TSTitle", c.blue)
Group.new("TSType", c.darkgreen)
Group.new("TSString", c.string)

-- diagnostics
Group.new("DiagnosticUnderlineError", nil, nil, s.undercurl + s.bold, c.red)
Group.new("DiagnosticUnderlineWarn", nil, nil, s.undercurl + s.bold, c.orange)
Group.new("DiagnosticUnderlineHint", nil, nil, s.undercurl + s.bold, c.white)
Group.new("DiagnosticUnderlineInfo", nil, nil, s.undercurl + s.bold, c.blue:light())

vim.cmd([[highlight! Normal ctermbg=none guibg=none]])
vim.cmd([[highlight! LineNr guibg=none guifg=#666a70]])
vim.cmd([[highlight! Search guibg=peru guifg=wheat]])
vim.cmd([[highlight! SignColumn guibg=none]])
vim.cmd([[highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080]])
vim.cmd([[highlight! CmpItemAbbrMatch guibg=NONE guifg=#f8fe7a]])
vim.cmd([[highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#f8fe7a]])
vim.cmd([[highlight! CmpItemKindVariable guibg=NONE guifg=#F5CD8E]])
vim.cmd([[highlight! CmpItemKindField guibg=NONE guifg=#F5CD8E]])
vim.cmd([[highlight! CmpItemKindEnumMember guibg=NONE guifg=#F5CD8E]])
vim.cmd([[highlight! CmpItemKindConstant guibg=NONE guifg=#F5CD8E]])
vim.cmd([[highlight! CmpItemKindInterface guibg=NONE guifg=#A1D091]])
vim.cmd([[highlight! CmpItemKindClass guibg=NONE guifg=#90D1EA]])
vim.cmd([[highlight! CmpItemKindEnum guibg=NONE guifg=#90D1EA]])
vim.cmd([[highlight! CmpItemKindText guibg=NONE guifg=#9AA7B0]])
vim.cmd([[highlight! CmpItemKindSnippet guibg=NONE guifg=#9AA7B0]])
vim.cmd([[highlight! CmpItemKindFunction guibg=NONE guifg=#F9B9C4]])
vim.cmd([[highlight! CmpItemKindMethod guibg=NONE guifg=#F9B9C4]])
vim.cmd([[highlight! CmpItemKindKeyword guibg=NONE guifg=#9AA7B0]])
vim.cmd([[highlight! CmpItemKindProperty guibg=NONE guifg=#D3C2F8]])
vim.cmd([[highlight! CmpItemKindUnit guibg=NONE guifg=#9AA7B0]])
