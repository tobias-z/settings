Settings = {}

local default_config = {
  tab_size = 4,
}

local tab_settings = {
  {
    file_types = {
      "yml",
      "yaml",
      "tex",
      "lua",
      "markdown",
      "terraform",
      "yaml.ansible",
      "scala"
    },
    config = {
      tab_size = 2,
    },
  },
}

Settings.get_config = function(language)
  for _, value in pairs(tab_settings) do
    for _, file_type in pairs(value.file_types) do
      if file_type == language then
        return value.config
      end
    end
  end

  return default_config
end
