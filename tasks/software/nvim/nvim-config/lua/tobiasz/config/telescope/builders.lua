local builders = {}

local search_theme = "dropdown"
local action_theme = "cursor"

function builders.with_layout(tbl)
  -- table.borderchars = {
  --     { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
  --     prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
  --     results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
  --     preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
  -- }
  tbl.prompt_title = false
  tbl.preview_title = false
  return tbl
end

function builders.search(with_preview)
  local search_no_preview = {
    theme = search_theme,
    layout_strategy = "horizontal",
    layout_config = {
      width = with_preview and 0.8 or 0.4,
      height = with_preview and 0.5 or 0.4,
      preview_cutoff = 10,
      prompt_position = "top",
      -- mirror = true,
    },
  }

  if with_preview then
    search_no_preview.layout_config.preview_width = 0.5
  else
    search_no_preview.previewer = false
  end

  return builders.with_layout(search_no_preview)
end

function builders.search_with_preview(_opts)
  return vim.tbl_deep_extend("force", builders.search(true), _opts or {})
end

function builders.search_no_preview(_opts)
  return vim.tbl_deep_extend("force", builders.search(false), _opts or {})
end

function builders.cursor_theme()
  return builders.with_layout({
    theme = action_theme,
    layout_config = {
      width = 0.65,
      preview_width = 0.45,
      height = 0.4,
    },
  })
end

return builders
