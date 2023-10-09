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
        path = "noice",
        defer = 1,
    },

    illuminate = {
        enabled = true,
        path = "illuminate",
        defer = 1,
    },

    lua_line = {
        enabled = true,
        path = "lualine",
        which = "evil",
        defer = 0.5
    },

    startup_screen = {
       enabled = true,
       path = "alpha",
       which = "",
       defer = 2
    },

    tabnine_info = {
        show_on_lualine = false,
        enabled = true,
        path = "tabnine",
        debounce_ms = 500,
        defer = 2
    },

    nodefaults_info = {path = "nodefault",enabled = true},

    my_user_commands_info = {
        prefix = "my",
        enabled = false
    },

    ["nvim-tree"] = {
        enabled = true,
        on_startup = false,
        path = "nvim-tree",
        defer = 1
    },

    background = {
        transparent = false,
    },

    color_scheme = {
        allow_custom = true,
        name = "tokyonight-night",
        arg = "darker"
    },

    lsp_trouble = {
        enabled = true,
        path = "trouble",
        defer = 1
    },

    terminal = {
        enabled = true,
        path = "term",
        defer = 1
    },

    tabs = {
        enabled = false,
        path = "barbar"
    },

    file_explorer = {
        enabled = true,
        path = "oil"
    },

    lsp = {
        enabled = true,
        paths = {"lsp","cmp"},
        defer = 1
    }
}

return options
