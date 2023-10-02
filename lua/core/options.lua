local options = {
    want_lazy_plugins = false, -- package manager --
    want_godot_mode = true,
    want_my_user_commands = true,
    want_default_keybinds = true,
    want_tree_sitter = true,
    want_lualine = false,
    want_treesj = true,
    want_builtin_terminal = true,

    my_user_commands_info = {
        prefix = "my"
    },

    ["nvim-tree"] = {
        enabled = false,
        on_startup = false
    },

    background = {
        is_transparent = false,
    },

    color_scheme = {
        allow_custom = true,
        name = "gruvbox",
        arg1 = "darker"
    },

    support_images = {
        enabled = true,
        path = "hologram"
    },

    lsp_trouble = {
        enabled = true,
        on_startup = false,
        path = "trouble"
    },

    terminal = {
        enabled = true,
        path = "toggle_term"
    },

    tabs = {
        enabled = true,
        path = "barbar"
    },

    lsp = {
        enabled = true
    }
}

return options
