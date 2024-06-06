local plugin_settings = nil
local io_funcs = require "helper.io_func"
local notify = require "notify"

local plugin_settings_path = io_funcs.get_config_loc() .. "/settings/plugin_settings.toml"
local file_content = io_funcs.read_all_file(plugin_settings_path)
local TOML = require "vendor.lua-toml.toml"

local defaults = {
    plugins = {
        enabled = true,
        deferring_enabled = false
    },

    telescope = {
        enabled = true,
        modules = {builtin = "telescope.builtin",config = "core.telescope"}
    },

    git = {
        enabled = true,
        gitblame_inline = false,
        modules = {gitsigns = "gitsigns",gitcore = "core.git"},
    },

    which_key = {
        enabled = true,
        module = "core.which_key"
    },

    goto = {
        enabled = true,
        module = "goto-preview"
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
        module = "core.ufo"
    },

    undotree = {
        enabled = true,
    },

    noice = {
        enabled = true,
        module = "core.noice",
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
        module = "core.illuminate",
    },

    status_line = {
        enabled = true,
        module = "core.status_line",
        style = "",
        name = "lualine",
    },

    tree_sitter = {
        enabled = true,
        module = "core.treesitter",
    },

    webdev_icons = {
        enabled = true,
        module = "core.webdev_icons"
    },

    treesj = {
        enabled = true,
    },

    alpha = {
       enabled = false,
       module = "core.alpha",
    },

    conform = {
        enabled = true,
        module = "core.conform"
    },

    nvim_tree = {
        enabled = true,
        on_startup = false,
        side = "left",
        module = "core.nvim_tree",
        width = 30,
        adaptive_size = true,
        show_dotfiles = true,
        show_gitignore = false,
    },

    discord = {
        enabled = false,
        module = "core.discord_presence",
        style = "presence",
    },

    godot = {
        enabled = false,
        module = "core.godot"
    },

    theme = {
        enabled = true,
        name = "vscode",
        transparent = false,
    },

    trouble = {
        enabled = false,
        module = "trouble",
    },

    terminal = {
        enabled = true,
        module = "core.toggleterm",
    },

    tabs = {
        enabled = true,
        module = "core.barbar",
    },

    file_explorer = {
        enabled = true,
        module = "core.oil"
    },

    lsp = {
        enabled = true,
        modules = {lsp = "core.lsp",cmp = "core.cmp"},
    },
}

plugin_settings = not file_content and defaults or TOML.parse(file_content,{strict = true})

if not plugin_settings then return {} end

coroutine.resume(coroutine.create(function()
    --NOTE: Adding missing plugin data
    for plugin_name,data in pairs(defaults) do
        if plugin_name ~= "out_of_date" then
            if plugin_settings[plugin_name] == nil and defaults[plugin_name] then
                plugin_settings.out_of_date = true
                plugin_settings[plugin_name] = data
            end
        end
        if type(data) == "table" then
            for opt, default_value in pairs(data) do
                if plugin_settings[plugin_name][opt] == nil then
                    plugin_settings.out_of_date = true
                    plugin_settings[plugin_name][opt] = default_value
                end
            end
        end
    end

    for plugin_name, data in pairs(plugin_settings) do
        if plugin_name ~= "out_of_date" then
            if defaults[plugin_name] == nil then
                plugin_settings[plugin_name] = nil
                plugin_settings.out_of_date = true
            end
        end
        if type(data) == "table" then
            for opt, value in pairs(data) do
                --NOTE: Removing outdated plugins
                if defaults[plugin_name][opt] == nil then
                    plugin_settings[plugin_name][opt] = nil
                    plugin_settings.out_of_date = true
                end
                if type(value) ~= type(defaults[plugin_name][opt]) then
                    notify(string.format("%s::%s is not the same type as reference table.",plugin_name,opt,plugin_name),"error")
                end
                if plugin_settings[plugin_name][opt] and opt == "module" then
                    if value ~= defaults[plugin_name][opt] then
                        plugin_settings[plugin_name][opt] = defaults[plugin_name][opt]
                    end
                elseif plugin_settings[plugin_name][opt] and opt == "modules" then
                    for mod_name, mod_path in pairs(type(value) == "table" and value or {}) do
                        if defaults[plugin_name][opt][mod_name] ~= mod_path then
                            plugin_settings[plugin_name][opt][mod_name] = defaults[plugin_name][opt][mod_name] 
                            plugin_settings.out_of_date = true
                        end
                    end
                end
            end
        end
    end

    coroutine.yield()
end))

return plugin_settings
