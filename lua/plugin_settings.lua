local plugin_settings = nil
local table_e = require "helper.table_e"

local file = require "helper.file"
local file_data = require "helper.file_data"
local preferences = require "preferences"
local JSON = require("helper.json")

if not preferences then return error "Failed to fetch prefernces in plugin_settings.lua" end

local defaults = {
    telescope = {
        enabled = true,
        modules = {builtin = "telescope.builtin",config = "plugin_conf.telescope"}
    },

    git = {
        enabled = true,
        modules = {gitsigns = "gitsigns",gitcore = "plugin_conf.git"},
    },

    tmux_nav = {
        enabled = true,
        module = "plugin_conf.tmux_nav"
    },

    which_key = {
        enabled = true,
        module = "plugin_conf.which_key"
    },

    harpoon = {
        enabled = true,
        module = "plugin_conf.harpoon"
    },

    dap = {
        enabled = false,
        module = "plugin_conf.dap"
    },

    numb = {
        enabled = true,
        module = "plugin_conf.numb"
    },

    undotree = {
        enabled = true,
    },

    lualine = {
        enabled = true,
        module = "plugin_conf.status_line"
    },

    refactoring = {
        enabled = true,
        module = "refactoring",
    },

    webdev_icons = {
        enabled = true,
        module = "plugin_conf.webdev_icons"
    },

    treesj = {
        enabled = true,
        modules = {_ = "plugin_conf.treesj"}
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
        enabled = false,
        module = "plugin_conf.godot"
    },

    file_explorer = {
        enabled = true,
        module = "plugin_conf.oil"
    },

    lsp = {
        enabled = true,
        modules = {lsp = "plugin_conf.lsp",cmp = "plugin_conf.cmp"}
    },
}

local metadata = nil

if preferences.conf.save_config then
    metadata = file_data.create({file_name = "plugins.json"})
    if not metadata then return print "failed to create metadata in plugin_settings.lua" end
    local file_content = file.read_all_file(metadata.path)
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

do 
    local new_state = preferences.conf.template ~= "minimal"

    for key in pairs(plugin_settings) do
        if key ~= "lsp" and plugin_settings[key].enabled then
            plugin_settings[key].enabled = new_state
        end
    end
end

if not plugin_settings then
    print "Something went wrong in plugin_settings.lua"
    return defaults
end

if preferences.conf.validate_config then
    coroutine.resume(coroutine.create(function()
        -- table_e.validate_config_table(defaults,plugin_settings,{},{})
    end))
end

if preferences.conf.template == "minimal" then
    plugin_settings.lsp.module = "plugin_conf.lsp_minimal"
end

return plugin_settings
