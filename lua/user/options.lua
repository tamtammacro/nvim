local options = {
    want_default_keybinds = true,
    want_telescope = true,
    want_leap = true,

    plugins = {
        enabled = true,
        --defer = .5
    },

    git = {
        enabled = true,
        paths = {"gitsigns"}
    },

    noice = {
        enabled = false,
        path = "noice",
        defer = 1,
    },

    refractoring = {
        enabled = true,
        path = "refractoring",
    },

    highlighted_indentation = {
        enabled = true,
        path = "ibl",
        defer = 1
    },

    highlighted_colors = {
        enabled = true,
        path = "colorizer",
        defer = 1,
    },

    symbols_outline = {
        enabled = true,
        path = "symbols-outline",
        defer = 1
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
    },

    tree_sitter = {
        enabled = true,
        path = "treesitter",
        defer = 2
    },

    treesj = {
        enabled = true,
    },

    startup_screen = {
       enabled = true,
       path = "alpha",
    },

    tabnine_info = {
        show_on_lualine = false,
        enabled = true,
        path = "tabnine",
        debounce_ms = 500,
        defer = 2
    },

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
