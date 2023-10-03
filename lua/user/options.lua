local options = {
    want_default_keybinds = true,
    want_tree_sitter = true,
    want_treesj = true,
    want_builtin_terminal = true,
    want_telescope = true,
    want_git_intigration = true,
    want_highlighted_indentation = true,

    noice = {
        enabled = true,
        path = "noice"
    },

    illuminate = {
        enabled = true,
        path = "illuminate"
    },

    lua_line = {
        enabled = true,
        path = "lualine",
        which = "evil"
    },

    tabnine_info = {
        show_on_lualine = true,
        enabled = true,
        path = "tabnine",
        debounce_ms = 500
    },

    nodefaults_info = {path = "nodefault",enabled = true},

    my_user_commands_info = {
        prefix = "my",
        enabled = false
    },

    ["nvim-tree"] = {
        enabled = true,
        on_startup = false
    },

    background = {
        transparent = false,
    },

    color_scheme = {
        allow_custom = true,
        name = "tokyonight-night",
        arg1 = "darker"
    },

    support_images = {
        enabled = true,
        path = "hologram"
    },

    lsp_trouble = {
        enabled = true,
        on_startup = true,
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

    file_explorer = {
        enabled = true,
        name = "oil"
    },

    lsp = {
        enabled = true,
    }
}

return options
