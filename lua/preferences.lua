local io_funcs = require "helper.io_func"
local fmeta = require "helper.fmeta"

local defaults = {
    theme = {
        enabled = true,
        name = "vscode",
    },
    background = {
        transparent = false,
        mode = "dark"
    },
    editor = {
        termguicolors = true
    }
}

defaults.__metadata__ = fmeta.create_fmd({file_name = "preferences.toml"})

local file_content = io_funcs.read_all_file(defaults.__metadata__.path)
local TOML = require "vendor.lua-toml.toml"

local preferences = not file_content and defaults or TOML.parse(file_content,{strict = true})

if not preferences then
    print "ERROR: Something went wrong in preferences.lua"
    return defaults
end

setmetatable(preferences,{__index = function(self,key)
	if key == "__metadata__" then
		return rawget(defaults,"__metadata__")
	end

    return rawget(self,key)
end})

coroutine.resume(coroutine.create(function()
    for pref_name,data in pairs(defaults) do
        if pref_name ~= "__metadata__" then
            if preferences[pref_name] == nil and defaults[pref_name] then
                preferences.__metadata__.out_of_date = true
                preferences[pref_name] = data
            end
        end
        if type(data) == "table" then
            for opt, default_value in pairs(data) do
                if preferences[pref_name][opt] == nil then
                    preferences.__metadata__.out_of_date = true
                    preferences[pref_name][opt] = default_value
                end
            end
        end
    end

    for pref_name, data in pairs(preferences) do
        if pref_name ~= "__metadata__" then
            if defaults[pref_name] == nil then
                preferences[pref_name] = nil
                preferences.__metadata__.out_of_date = true
            end
        end
        if type(data) == "table" then
            for opt, value in pairs(data) do
                if defaults[pref_name][opt] == nil then
                    preferences[pref_name][opt] = nil
                    preferences.__metadata__.out_of_date = true
                end
                if type(value) ~= type(defaults[pref_name][opt]) then
                    print(string.format("%s::%s is not the same type as reference table.",pref_name,opt,pref_name))
                end
            end
        end
    end

    coroutine.yield()
end))


return preferences
