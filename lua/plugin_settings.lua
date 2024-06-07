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
        modules = {builtin = "telescope.builtin",config = "plugin_config.telescope"}
    },

    git = {
        enabled = true,
        gitblame_inline = false,
        modules = {gitsigns = "gitsigns",gitcore = "plugin_config.git"},
    },

    which_key = {
        enabled = true,
        module = "plugin_config.which_key"
    },

    goto = {
        enabled = true,
        module = "goto-preview"
    },

    dap = {
        enabled = true,
        module = "plugin_config.dap"
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
        module = "plugin_config.ufo"
    },

    undotree = {
        enabled = true,
    },

    noice = {
        enabled = false,
        module = "plugin_config.noice",
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
        module = "plugin_config.illuminate",
    },

    status_line = {
        enabled = true,
        module = "plugin_config.status_line",
        style = "",
        name = "lualine",
    },

    tree_sitter = {
        enabled = true,
        module = "plugin_config.treesitter",
    },

    webdev_icons = {
        enabled = true,
        module = "plugin_config.webdev_icons"
    },

    treesj = {
        enabled = true,
    },

    alpha = {
       enabled = false,
       module = "plugin_config.alpha",
    },

    conform = {
        enabled = true,
        module = "plugin_config.conform"
    },

    nvim_tree = {
        enabled = true,
        on_startup = false,
        side = "left",
        module = "plugin_config.nvim_tree",
        width = 30,
        adaptive_size = true,
        show_dotfiles = true,
        show_gitignore = false,
    },

    discord = {
        enabled = false,
        module = "plugin_config.discord_presence",
        style = "presence",
    },

    godot = {
        enabled = true,
        module = "plugin_config.godot"
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
        module = "plugin_config.toggleterm",
    },

    tabs = {
        enabled = true,
        module = "plugin_config.barbar",
    },

    file_explorer = {
        enabled = true,
        module = "plugin_config.oil"
    },

    lsp = {
        enabled = true,
        modules = {lsp = "plugin_config.lsp",cmp = "plugin_config.cmp"},
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
                        plugin_settings.out_of_date = true
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
