local plugin_settings = nil
local io_funcs = require "helper.io_func"
local fmeta = require "helper.fmeta"
local preferences = require "preferences"
local JSON = require("vendor.json.json")

local defaults = {
    telescope = {
        enabled = true,
        modules = {builtin = "telescope.builtin",config = "plugin_conf.telescope"}
    },

    git = {
        enabled = true,
        modules = {gitsigns = "gitsigns",gitcore = "plugin_conf.git"},
    },

    which_key = {
        enabled = false,
        module = "plugin_conf.which_key"
    },

    goto = {
        enabled = true,
        module = "goto-preview"
    },

    dap = {
        enabled = false,
        module = "plugin_conf.dap"
    },

    numb = {
        enabled = true,
        module = "plugin_conf.numb"
    },

    my_quick_actions = {
        enabled = true,
        module = "core.my_quick_actions"
    },

    split_controls = {
        enabled = true
    },

    ufo = {
        enabled = true,
        module = "plugin_conf.ufo"
    },

    undotree = {
        enabled = true,
    },

    noice = {
        enabled = false,
        module = "plugin_conf.noice",
    },

    refactoring = {
        enabled = true,
        module = "refactoring",
    },

    ibl = {
        enabled = true,
        module = "ibl",
    },

    colorizer = {
        enabled = true,
        module = "colorizer",
    },

    symbols_outline = {
        enabled = true,
        module = "symbols-outline",
    },

    illuminate = {
        enabled = true,
        module = "plugin_conf.illuminate",
    },

    status_line = {
        enabled = true,
        module = "plugin_conf.status_line",
    },

    tree_sitter = {
        enabled = true,
        module = "plugin_conf.treesitter",
    },

    webdev_icons = {
        enabled = true,
        module = "plugin_conf.webdev_icons"
    },

    treesj = {
        enabled = true,
    },

    alpha = {
       enabled = false,
       module = "plugin_conf.alpha",
    },

    conform = {
        enabled = true,
        module = "plugin_conf.conform"
    },

    nvim_tree = {
        enabled = true,
        module = "plugin_conf.nvim_tree",
    },

    discord = {
        enabled = false,
        module = "plugin_conf.discord_presence",
    },

    godot = {
        enabled = true,
        module = "plugin_conf.godot"
    },

    trouble = {
        enabled = false,
        module = "trouble",
    },

    terminal = {
        enabled = true,
        module = "plugin_conf.toggleterm",
    },

    tabs = {
        enabled = true,
        module = "plugin_conf.barbar",
    },

    file_explorer = {
        enabled = true,
        module = "plugin_conf.oil"
    },

    lsp = {
        enabled = true,
        modules = {lsp = "plugin_conf.lsp",cmp = "plugin_conf.cmp"},
    },
}

local metadata = fmeta.create_fmd({file_name = "plugins.json"})
local file_content = io_funcs.read_all_file(metadata.path)
plugin_settings = not file_content and defaults or JSON.decode(file_content)

setmetatable(plugin_settings,{__index = function(self,key)
	if key == "__metadata__" then
		return metadata
	end

    return rawget(self,key)
end})

if not plugin_settings then
    print "ERROR: Something went wrong in plugin_settings.lua"
    return defaults
end

coroutine.resume(coroutine.create(function()
    for plugin_name,data in pairs(defaults) do
        if plugin_name ~= "__metadata__" then

            if plugin_settings[plugin_name] == nil and defaults[plugin_name] then
                plugin_settings.__metadata__.out_of_date = true
                plugin_settings[plugin_name] = data
            end

            if type(data) == "table" then
                for opt, default_value in pairs(data) do
                    if plugin_settings[plugin_name][opt] == nil then
                        plugin_settings.__metadata__.out_of_date = true
                        plugin_settings[plugin_name][opt] = default_value
                    end
                end
            end
        end
    end

    for plugin_name, data in pairs(plugin_settings) do
        if defaults[plugin_name] == nil then
            plugin_settings[plugin_name] = nil
            metadata.out_of_date = true
        end

        if type(data) == "table" then
            for opt, value in pairs(data) do
                if defaults[plugin_name][opt] == nil and opt ~= "defer" then
                    plugin_settings[plugin_name][opt] = nil
                    metadata.out_of_date = true
                    print(opt)
                end
                if opt ~= "defer" and type(value) ~= type(defaults[plugin_name][opt]) then
                    print(string.format("%s::%s is not the same type as reference table.",plugin_name,opt,plugin_name))
                end
                if plugin_settings[plugin_name][opt] and opt == "module" then
                    if value ~= defaults[plugin_name][opt] then
                        plugin_settings[plugin_name][opt] = defaults[plugin_name][opt]
                        metadata.out_of_date = true
                    end
                elseif plugin_settings[plugin_name][opt] and opt == "modules" then
                    for mod_name, mod_path in pairs(type(value) == "table" and value or {}) do
                        if defaults[plugin_name][opt][mod_name] ~= mod_path then
                            plugin_settings[plugin_name][opt][mod_name] = defaults[plugin_name][opt][mod_name]
                            metadata.out_of_date = true
                        end
                    end
                end
            end
        end
    end

    -- coroutine.yield()
end))

return plugin_settings
