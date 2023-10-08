local options = {
    want_default_keybinds = true,
    want_tree_sitter = true,
    want_treesj = true,
    want_builtin_terminal = true,
    want_telescope = true,
    want_git_intigration = true,
    want_highlighted_indentation = true,
    want_highlighted_colors = true,
    want_symbols_outlined = true,
    want_leap = true,

    noice = {
        enabled = false,
        path = "noice"
    },

    illuminate = {
        enabled = false,
        path = "illuminate"
    },

    lua_line = {
        enabled = true,
        path = "lualine",
        which = "evil"
    },

    tabnine_info = {
        show_on_lualine = false,
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
        on_startup = false,
        path = "nvim-tree"
    },

    background = {
        transparent = false,
    },

    color_scheme = {
        allow_custom = true,
        name = "gruvbox",
        arg1 = "darker"
    },

    support_images = {
        enabled = false,
        path = "hologram"
    },

    lsp_trouble = {
        enabled = true,
        on_startup = true,
        path = "trouble"
    },

    terminal = {
        enabled = true,
        path = "term"
    },

    tabs = {
        enabled = false,
        path = "barbar"
    },

    file_explorer = {
        enabled = true,
        name = "oil",
        path = "oil"
    },

    lsp = {
        enabled = true,
        paths = {"lsp","cmp"}
    }
}

return options
