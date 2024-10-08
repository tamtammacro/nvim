local io_funcs = require("helper.io_func")
local fmeta = require("helper.fmeta")

local defaults = {
	conf = {
	    template = "minimal",
		enable_plugin_check = false,
	},
	editor = {
        file_explorer = {
            name = "netrw"
        },
		theme = {
			name = "desert",
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

local metadata = fmeta.create_fmd({ file_name = "preferences.json" })

if not metadata then
	return print("Could not create metadata for preferences")
end

local file_content = io_funcs.read_all_file(metadata.path)
local JSON = require("helper.json")

local preferences = not file_content and defaults or JSON.decode(file_content)

if not preferences then
	print("ERROR: Something went wrong in preferences.lua")
	return defaults
end

setmetatable(preferences, {
	__index = function(self, key)
		if key == "__metadata__" then
			return metadata
		end

		return rawget(self, key)
	end,
})

if preferences.conf.enable_plugin_check then
	coroutine.resume(coroutine.create(function()
		for pref_name, data in pairs(defaults) do
			if pref_name ~= "__metadata__" then
				if preferences[pref_name] == nil and defaults[pref_name] then
					metadata.out_of_date = true
					preferences[pref_name] = data
				end
			end
			if type(data) == "table" then
				for opt, default_value in pairs(data) do
					if preferences[pref_name][opt] == nil then
						metadata.out_of_date = true
						preferences[pref_name][opt] = default_value
					end
				end
			end
		end

		for pref_name, data in pairs(preferences) do
			if pref_name ~= "__metadata__" then
				if defaults[pref_name] == nil then
					preferences[pref_name] = nil
					metadata.out_of_date = true
				end
			end
			if type(data) == "table" then
				for opt, value in pairs(data) do
					if defaults[pref_name][opt] == nil then
						preferences[pref_name][opt] = nil
						metadata.out_of_date = true
					end
					if type(value) ~= type(defaults[pref_name][opt]) then
						print(
							string.format("%s::%s is not the same type as reference table.", pref_name, opt, pref_name)
						)
					end
				end
			end
		end

		coroutine.yield()
	end))
end

return preferences
