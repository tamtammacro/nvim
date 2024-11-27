local file = require("helper.file")
local table_e = require "helper.table_e"
local file_data = require("helper.file_data")

local defaults = {
	conf = {
		template = "everything",
		validate_config = false,
		save_config_to_json = false,
	},
	editor = {
		file_explorer = {
			name = "netrw",
		},
		theme = {
			name = "onedark",
		},
		background = {
			transparent = false,
			termguicolors = true,
			mode = "dark",
		},
		explorer = {
			side = "left",
			width = 30,
			on_startup = false,
			adaptive_size = true,
			show_dotfiles = true,
			show_gitignore = false,
		},
		status_line = {
			style = "",
			name = "lualine",
		},
	},
	git = {
		gitblame_inline = true,
	},
}

local preferences = nil
local metadata = nil

if defaults.conf.save_config_to_json then
	metadata = file_data.create({ file_name = "preferences.json" })

	if not metadata then
		return print("Could not create metadata for preferences")
	end

	local file_content = file.read_all_file(metadata.path)
	local JSON = require("helper.json")

	preferences = not file_content and defaults or JSON.decode(file_content)

	if not preferences then
		print("ERROR: Something went wrong in preferences.lua")
		return defaults
	end
else
	preferences = defaults
end

setmetatable(preferences, {
	__index = function(self, key)
		if key == "__metadata__" then
			return metadata or {}
		end

		return rawget(self, key)
	end,
})

return preferences
