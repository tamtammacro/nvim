local plugin_settings = nil
local io_funcs = require "helper.io_func"

local path = io_funcs.get_config_loc() .. "/settings/plugin_settings.toml"
local file_content = io_funcs.read_all_file(path)
local TOML = require "vendor.lua-toml.toml"

if not file_content then
    -- defaults --
    plugin_settings = {
        plugins = {
            enabled = true,
            deferring_enabled = false
        },

        telescope = {
            enabled = true,
            modules = {["builtin"] = "telescope.builtin",["config"] = "telescope_config"}
        },

        git = {
            enabled = true,
            module = "gitsigns",
            defer = 1
        },

        goto = {
            enabled = true,
            module = "goto-preview"
        },

        my_quick_actions = {
            enabled = true,
            module = "my_quick_actions"
        },

        split_controls = {
            enabled = true
        },

        ufo = {
            enabled = true,
            module = "ufo"
        },

        undotree = {
            enabled = true,
        },

        noice = {
            enabled = false,
            module = "noice",
        },

        refractoring = {
            enabled = true,
            module = "refractoring",
        },

        highlight_indentation = {
            enabled = true,
            module = "ibl",
        },

        colorizer = {
            enabled = true,
            module = "colorizer",
        },

        auto_tag = {
            enabled = true,
            module = "auto_tag"
        },

        symbols_outline = {
            enabled = true,
            module = "symbols-outline",
        },

        illuminate = {
            enabled = true,
            module = "illuminate",
        },

        status_line = {
            enabled = true,
            module = "status_line",
            style = "",
            name = "lualine",
        },

        tree_sitter = {
            enabled = true,
            module = "treesitter",
        },

        webdev_icons = {
            enabled = true,
            module = "webdev_icons"
        },

        treesj = {
            enabled = true,
        },

        alpha = {
           enabled = true,
           module = "alpha",
        },

        conform = {
            enabled = true,
            module = "conform"
        },

        nvim_tree = {
            enabled = true,
            on_startup = false,
            side = "left",
            module = "nvim_tree",
            width = 30,
            adaptive_size = true,
            show_dotfiles = true,
            show_gitignore = false,
        },

        discord = {
            enabled = false,
            module = "discord_presence",
            style = "presence",
        },

        godot = {
            enabled = false,
            module = "godot"
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
            module = "term",
        },

        tabs = {
            enabled = true,
            module = "barbar"
        },

        file_explorer = {
            enabled = true,
            module = "oil"
        },

        lsp = {
            enabled = true,
            modules = {["lsp"] = "lsp",["cmp"] = "cmp"},
        }
    }
else
	local data = TOML.parse(file_content,{strict = true})

    if data then
        plugin_settings = data
    else
        plugin_settings = {}
    end
end

return plugin_settings
