local options = {
    want_lazy_plugins = false, -- package manager --
    want_godot_mode = true,
    want_default_keybinds = true,
    want_tree_sitter = true,
    want_lualine = true,
    want_treesj = true,
    want_builtin_terminal = true,
    want_telescope = true,
    want_git_intigration = true,

    tabnine_info = {
        show_on_lualine = true,
        enabled = true,
        path = "tabnine",
        debounce_ms = 500
    },

    nodefaults_info = {path = "nodefault",enabled = true},

    my_user_commands_info = {
        prefix = "my",
        enabled = true
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
        name = "vscode",
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
        enabled = false,
        path = "barbar"
    },

    lsp = {
        enabled = true
    }
}

return options
