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
            module = "core.barbar"
        },

        file_explorer = {
            enabled = true,
            module = "core.oil"
        },

        lsp = {
            enabled = true,
            modules = {lsp = "core.lsp",cmp = "core.cmp"},
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
