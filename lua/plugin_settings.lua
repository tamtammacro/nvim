local plugin_settings = nil
local io_funcs = require "helper.io_func"
local fmeta = require "helper.fmeta"
local preferences = require "preferences"
local JSON = require("helper.json")

if not preferences then return print "Failed to fetch prefernces in plugin_settings.lua" end

local defaults = {
    telescope = {
        enabled = false,
        modules = {builtin = "telescope.builtin",config = "plugin_conf.telescope"}
    },

    git = {
        enabled = false,
        modules = {gitsigns = "gitsigns",gitcore = "plugin_conf.git"},
    },

    which_key = {
        enabled = false,
        module = "plugin_conf.which_key"
    },

    goto = {
        enabled = false,
        module = "goto-preview"
    },

    dap = {
        enabled = false,
        module = "plugin_conf.dap"
    },

    numb = {
        enabled = false,
        module = "plugin_conf.numb"
    },

    my_quick_actions = {
        enabled = false,
        module = "core.my_quick_actions"
    },

    split_controls = {
        enabled = true
    },

    ufo = {
        enabled = false,
        module = "plugin_conf.ufo"
    },

    undotree = {
        enabled = false,
    },

    noice = {
        enabled = false,
        module = "plugin_conf.noice",
    },

    refactoring = {
        enabled = false,
        module = "refactoring",
    },

    ibl = {
        enabled = false,
        module = "ibl",
    },

    colorizer = {
        enabled = false,
        module = "colorizer",
    },

    symbols_outline = {
        enabled = false,
        module = "symbols-outline",
    },

    illuminate = {
        enabled = false,
        module = "plugin_conf.illuminate",
    },

    status_line = {
        enabled = false,
        module = "plugin_conf.status_line",
    },

    tree_sitter = {
        enabled = false,
        module = "plugin_conf.treesitter",
    },

    webdev_icons = {
        enabled = false,
        module = "plugin_conf.webdev_icons"
    },

    treesj = {
        enabled = false,
    },

    alpha = {
       enabled = false,
       module = "plugin_conf.alpha",
    },

    conform = {
        enabled = false,
        module = "plugin_conf.conform"
    },

    nvim_tree = {
        enabled = false,
        module = "plugin_conf.nvim_tree",
    },

    discord = {
        enabled = false,
        module = "plugin_conf.discord_presence",
    },

    godot = {
        enabled = false,
        module = "plugin_conf.godot"
    },

    trouble = {
        enabled = false,
        module = "trouble",
    },

    terminal = {
        enabled = false,
        module = "plugin_conf.toggleterm",
    },

    tabs = {
        enabled = false,
        module = "plugin_conf.barbar",
    },

    file_explorer = {
        enabled = false,
        module = "plugin_conf.oil"
    },

    lsp = {
        enabled = true,
        module = "plugin_conf.lsp_minimal"
        -- modules = {lsp = "plugin_conf.lsp",cmp = "plugin_conf.cmp"},
    },
}

local metadata = nil

if preferences.conf.save_config then
    metadata = fmeta.create_fmd({file_name = "plugins.json"})
    if not metadata then return print "failed to create metadata in plugin_settings.lua" end
    local file_content = io_funcs.read_all_file(metadata.path)
    plugin_settings = not file_content and defaults or JSON.decode(file_content)
else
    plugin_settings = defaults
end

setmetatable(plugin_settings,{__index = function(self,key)
	if key == "__metadata__" then
		return metadata or {}
	end

    return rawget(self,key)
end})

if not plugin_settings then
    print "ERROR: Something went wrong in plugin_settings.lua"
    return defaults
end

if preferences.conf.enable_plugin_check then
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

end
return plugin_settings
